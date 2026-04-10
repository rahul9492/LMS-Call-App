import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/auth_providers.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String mobileNumber;
  final String? debugCode;

  const OtpScreen({super.key, required this.mobileNumber, this.debugCode});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen>
    with SingleTickerProviderStateMixin {
  static const int _otpLength = 6;
  static const int _resendCooldown = 30;

  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  bool _isVerifying = false;
  bool _isResending = false;
  int _resendTimer = _resendCooldown;
  Timer? _timer;
  String? _debugCode;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _debugCode = widget.debugCode;
    _animController.forward();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer = _resendCooldown;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _resendTimer--;
        if (_resendTimer <= 0) t.cancel();
      });
    });
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    // Auto-verify when all digits filled
    if (_otp.length == _otpLength) {
      _verify();
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  Future<void> _verify() async {
    if (_otp.length < _otpLength || _isVerifying) return;
    setState(() => _isVerifying = true);
    try {
      final success = await ref
          .read(authProvider.notifier)
          .verifyOtp(widget.mobileNumber, _otp);
      if (!mounted) return;
      if (success) {
        // Navigate to home, clearing the entire back stack
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.home,
          (_) => false,
        );
      } else {
        _clearOtp();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect OTP. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  Future<void> _resendOtp() async {
    if (_resendTimer > 0 || _isResending) return;
    setState(() => _isResending = true);
    try {
      final newCode = await ref
          .read(authProvider.notifier)
          .requestOtp(widget.mobileNumber);
      if (!mounted) return;
      setState(() { _debugCode = newCode; });
      _clearOtp();
      _startResendTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP resent')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resend: $e')),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  void _clearOtp() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final maskedNumber = _maskedMobile(widget.mobileNumber);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  // Icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.sms_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Verify your number',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(
                            text: 'Enter the 6-digit code sent to\n'),
                        TextSpan(
                          text: '+91 $maskedNumber',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // OTP banner — always shown (remove this block when real SMS OTP is integrated)
                  if (_debugCode != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.warning.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              color: AppColors.warning, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Dev mode — your code: $_debugCode',
                            style: const TextStyle(
                              color: AppColors.warning,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // OTP digit boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(_otpLength, (i) {
                      return _OtpDigitBox(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        onChanged: (val) => _onDigitChanged(i, val),
                        onKeyEvent: (event) => _onKeyEvent(i, event),
                        isLoading: _isVerifying,
                      );
                    }),
                  ),
                  const SizedBox(height: 36),

                  // Verify button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: (_isVerifying || _otp.length < _otpLength)
                          ? null
                          : _verify,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.accent.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isVerifying
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Resend row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      GestureDetector(
                        onTap: _resendTimer <= 0 ? _resendOtp : null,
                        child: _isResending
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary),
                              )
                            : Text(
                                _resendTimer > 0
                                    ? 'Resend in ${_resendTimer}s'
                                    : 'Resend OTP',
                                style: TextStyle(
                                  color: _resendTimer > 0
                                      ? AppColors.textMuted
                                      : AppColors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  String _maskedMobile(String mobile) {
    if (mobile.length <= 4) return mobile;
    final visible = mobile.substring(mobile.length - 4);
    final masked = '•' * (mobile.length - 4);
    return '$masked$visible';
  }
}

// ── OTP digit box ─────────────────────────────────────────────────────────────

class _OtpDigitBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<KeyEvent> onKeyEvent;
  final bool isLoading;

  const _OtpDigitBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onKeyEvent,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: onKeyEvent,
      child: SizedBox(
        width: 46,
        height: 56,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: !isLoading,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ).toInputDecoration(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

extension on BoxDecoration {
  InputDecoration toInputDecoration() {
    final radius = borderRadius is BorderRadius
        ? borderRadius as BorderRadius
        : BorderRadius.zero;
    final side = border?.top ?? BorderSide.none;
    return InputDecoration(
      filled: true,
      fillColor: color,
      border: OutlineInputBorder(borderRadius: radius, borderSide: side),
      enabledBorder: OutlineInputBorder(borderRadius: radius, borderSide: side),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
