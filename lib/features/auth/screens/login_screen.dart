import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final mobile = _mobileController.text.trim();
      final debugCode = await ref.read(authProvider.notifier).requestOtp(mobile);
      if (!mounted) return;
      Navigator.of(context).pushNamed(
        AppRoutes.otpVerify,
        arguments: {'mobile': mobile, 'debugCode': debugCode},
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 72),
                    // Logo / icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.phone_rounded,
                        color: AppColors.primary,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'LMS Call',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your mobile number to continue',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Country code + mobile field
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          // Country code chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 16),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: AppColors.border),
                              ),
                            ),
                            child: const Text(
                              '+91',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          // Mobile number input
                          Expanded(
                            child: TextFormField(
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Mobile number',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                if (val.trim().length < 10) {
                                  return 'Enter a valid 10-digit number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.lock_outline_rounded,
                            size: 13, color: AppColors.textMuted),
                        SizedBox(width: 5),
                        Text(
                          'We\'ll send a verification code to this number',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // Send OTP button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              AppColors.primary.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Send OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Footer
                    const Text(
                      'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
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
}
