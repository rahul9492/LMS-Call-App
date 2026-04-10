import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/sync/services/background_sync.dart';

class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late AnimationController _slideCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _isRequesting = false;

  final List<_PermissionItem> _permissions = [
    _PermissionItem(
      icon: Icons.phone_rounded,
      title: 'Phone & Call Logs',
      description:
          'Access your call history to track incoming, outgoing, and missed calls for lead management.',
      permission: Permission.phone,
      isRequired: true,
    ),
    _PermissionItem(
      icon: Icons.contacts_rounded,
      title: 'Contacts',
      description:
          'Match phone numbers with your contacts to show caller names automatically.',
      permission: Permission.contacts,
      isRequired: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));

    _fadeCtrl.forward();
    Future.delayed(const Duration(milliseconds: 200), _slideCtrl.forward);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    setState(() => _isRequesting = true);

    // Request all permissions
    final statuses = await [
      Permission.phone,
      Permission.contacts,
    ].request();

    final phoneGranted =
        statuses[Permission.phone]?.isGranted ?? false;

    if (!phoneGranted) {
      setState(() => _isRequesting = false);
      if (mounted) {
        _showPermissionDeniedDialog();
      }
      return;
    }

    // Mark onboarding complete
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefOnboardingComplete, true);

    // Register background sync
    await BackgroundSyncManager.registerPeriodicSync();

    setState(() => _isRequesting = false);

    if (mounted) {
      Navigator.of(context)
          .pushReplacementNamed(AppRoutes.home);
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Permission Required',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'LMS Call needs access to your call logs to work properly. '
          'Please grant the Phone permission in settings.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                // App logo / icon
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.phone_in_talk_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LMS Call',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Know who is calling before you answer',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Permission cards
                      ..._permissions.map((item) => _PermissionCard(item: item)),
                      const SizedBox(height: 16),
                      // Privacy note
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.shield_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Your data is stored securely on your device and only synced to your organization\'s LMS server.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Allow button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isRequesting ? null : _requestPermissions,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: _isRequesting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'ALLOW',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: _isRequesting
                        ? null
                        : () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool(
                                AppConstants.prefOnboardingComplete, true);
                            if (!mounted) return;
                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.home);
                          },
                    child: const Text(
                      "DON'T ALLOW",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Permission item model ────────────────────────────────────────────────

class _PermissionItem {
  final IconData icon;
  final String title;
  final String description;
  final Permission permission;
  final bool isRequired;

  const _PermissionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.permission,
    required this.isRequired,
  });
}

// ── Permission card widget ───────────────────────────────────────────────

class _PermissionCard extends StatelessWidget {
  final _PermissionItem item;

  const _PermissionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (item.isRequired) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Required',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
