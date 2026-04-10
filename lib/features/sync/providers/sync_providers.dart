import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/call_logs/providers/call_log_providers.dart';
import '../services/sync_service.dart';

part 'sync_providers.g.dart';

@Riverpod(keepAlive: true)
SyncService syncService(Ref ref) {
  return SyncService(
    ref.watch(callLogRepositoryProvider),
    ref.watch(apiServiceProvider),
    ref.watch(connectivityServiceProvider),
  );
}

@riverpod
class SyncNotifier extends _$SyncNotifier {
  @override
  AsyncValue<SyncResult?> build() => const AsyncValue.data(null);

  Future<void> sync() async {
    if (state.isLoading) return;
    state = const AsyncValue.loading();
    try {
      final svc = ref.read(syncServiceProvider);
      final result = await svc.runSync();
      state = AsyncValue.data(result);
      ref.invalidate(groupedCallLogsProvider);
      ref.invalidate(syncSummaryProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
