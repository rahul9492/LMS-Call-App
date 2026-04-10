import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../models/call_log_model.dart';

/// Wraps all HTTP communication with the LMS backend.
/// When the API is not yet available, every call will fail gracefully
/// and the caller (sync service) handles retry logic.
class ApiService {
  late final Dio _dio;

  /// Fires when the server returns 401 (token expired / invalid).
  /// The app listens to this stream and redirects to the login screen.
  final _unauthorizedController = StreamController<void>.broadcast();
  Stream<void> get onUnauthorized => _unauthorizedController.stream;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    // Auth interceptor — injects token + handles 401
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(AppConstants.prefAuthToken);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            debugPrint('[ApiService] 401 Unauthorized — clearing auth');
            // Clear stored credentials
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove(AppConstants.prefAuthToken);
            await prefs.remove(AppConstants.prefUserId);
            await prefs.remove(AppConstants.prefMobileNumber);
            await prefs.remove(AppConstants.prefAuthUser);
            // Notify listeners to redirect to login
            _unauthorizedController.add(null);
          }
          debugPrint('[ApiService] error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  void dispose() {
    _unauthorizedController.close();
  }

  /// Upload a batch of call logs to the API.
  /// Returns the list of IDs that were successfully accepted by the server.
  Future<List<String>> syncCallLogs(List<CallLogModel> logs) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString(AppConstants.prefUserId) ?? 'unknown';

      final payload = logs.map(_toApiPayload).toList();

      final response = await _dio.post(
        '/call-logs/sync',
        data: {'user_id': userId, 'call_logs': payload},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>?;
        final accepted = data?['accepted_ids'] as List<dynamic>?;
        if (accepted != null) {
          return accepted.map((e) => e.toString()).toList();
        }
        return logs.map((l) => l.id).toList();
      }

      throw ApiException(
        'Unexpected status ${response.statusCode}',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
        cause: e,
      );
    }
  }

  Map<String, dynamic> _toApiPayload(CallLogModel log) => {
        'id': log.id,
        'phone_number': log.phoneNumber,
        'contact_name': log.contactName,
        'call_type': log.callType.name,
        'timestamp': log.timestamp.toIso8601String(),
        'duration_seconds': log.durationSeconds,
        'ring_duration_seconds': log.ringDurationSeconds,
        'sim_display_name': log.simDisplayName,
        'sim_slot': log.simSlot,
      };
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  const ApiException(this.message, {this.statusCode, this.cause});

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() =>
      'ApiException($statusCode): $message${cause != null ? ' | cause: $cause' : ''}';
}
