import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/auth/providers/auth_providers.dart';
import '../../../features/call_logs/providers/call_log_providers.dart';
import '../../../features/sync/providers/sync_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncSummaryAsync = ref.watch(syncSummaryProvider);
    final onlineAsync = ref.watch(connectivityStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Sync status card
          _SectionCard(
            title: 'Sync Status',
            children: [
              syncSummaryAsync.when(
                data: (s) => Column(
                  children: [
                    _InfoRow(
                      label: 'Pending',
                      value: '${s.totalPending}',
                      valueColor: s.totalPending > 0
                          ? AppColors.syncPending
                          : AppColors.textSecondary,
                    ),
                    _InfoRow(
                      label: 'Synced',
                      value: '${s.totalSynced}',
                      valueColor: AppColors.syncSynced,
                    ),
                    _InfoRow(
                      label: 'Failed',
                      value: '${s.totalFailed}',
                      valueColor: s.totalFailed > 0
                          ? AppColors.syncFailed
                          : AppColors.textSecondary,
                    ),
                    if (s.lastSyncTime != null)
                      _InfoRow(
                        label: 'Last sync',
                        value: _formatDateTime(s.lastSyncTime!),
                        valueColor: AppColors.textSecondary,
                      ),
                  ],
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) =>
                    const Text('Could not load sync status'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Connectivity card
          _SectionCard(
            title: 'Connectivity',
            children: [
              onlineAsync.when(
                data: (isOnline) => _InfoRow(
                  label: 'Status',
                  value: isOnline ? 'Online' : 'Offline',
                  valueColor:
                      isOnline ? AppColors.success : AppColors.error,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Unknown'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Actions card
          _SectionCard(
            title: 'Actions',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.sync_rounded,
                      color: AppColors.primary, size: 20),
                ),
                title: const Text('Sync now'),
                subtitle: const Text('Upload pending call logs to server'),
                trailing: const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textMuted),
                onTap: () {
                  ref.read(syncProvider.notifier).sync();
                  Navigator.pop(context);
                },
              ),
              const Divider(color: AppColors.divider, height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.incoming.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.refresh_rounded,
                      color: AppColors.incoming, size: 20),
                ),
                title: const Text('Refresh call logs'),
                subtitle: const Text('Re-fetch logs from your phone'),
                trailing: const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textMuted),
                onTap: () {
                  ref.read(deviceSyncProvider.notifier).syncFromDevice();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // About card
          _SectionCard(
            title: 'About',
            children: [
              _InfoRow(label: 'App', value: AppConstants.appName),
              _InfoRow(label: 'Version', value: AppConstants.appVersion),
            ],
          ),
          const SizedBox(height: 16),

          // Account card
          _SectionCard(
            title: 'Account',
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.logout_rounded,
                      color: AppColors.error, size: 20),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: AppColors.error),
                ),
                subtitle: const Text('Sign out of your account'),
                trailing: const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textMuted),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: AppColors.card,
                      title: const Text('Logout'),
                      content:
                          const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: TextButton.styleFrom(
                              foregroundColor: AppColors.error),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await ref
                        .read(authProvider.notifier)
                        .logout();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.login,
                        (_) => false,
                      );
                    }
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const Divider(color: AppColors.divider, height: 0),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
