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
    final colors = context.colors;
    final syncSummaryAsync = ref.watch(syncSummaryProvider);
    final onlineAsync = ref.watch(connectivityStreamProvider);
    final authAsync = ref.watch(authProvider);
    final fetchDaysAsync = ref.watch(callLogFetchDaysProvider);

    return Scaffold(
      backgroundColor: colors.background,
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
          // ── Account ───────────────────────────────────────────────────────
          _SectionCard(
            title: 'Account',
            children: [
              authAsync.when(
                data: (user) => user != null
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: const Icon(Icons.person_rounded,
                                    color: AppColors.primary, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+91 ${user.mobileNumber}',
                                      style: TextStyle(
                                        color: colors.textPrimary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'ID: ${user.userId}',
                                      style: TextStyle(
                                        color: colors.textMuted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Divider(color: colors.divider, height: 1),
                        ],
                      )
                    : const SizedBox.shrink(),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox.shrink(),
              ),
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
                title: const Text('Logout',
                    style: TextStyle(color: AppColors.error)),
                subtitle: Text('Sign out of your account',
                    style: TextStyle(color: colors.textSecondary)),
                trailing: Icon(Icons.chevron_right_rounded,
                    color: colors.textMuted),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: colors.card,
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
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
                    await ref.read(authProvider.notifier).logout();
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
          const SizedBox(height: 16),

          // ── Sync Status ───────────────────────────────────────────────────
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
                          : colors.textSecondary,
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
                          : colors.textSecondary,
                    ),
                    if (s.lastSyncTime != null)
                      _InfoRow(
                        label: 'Last sync',
                        value: _formatDateTime(s.lastSyncTime!),
                        valueColor: colors.textSecondary,
                      ),
                  ],
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Could not load sync status'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Connectivity ──────────────────────────────────────────────────
          _SectionCard(
            title: 'Connectivity',
            children: [
              onlineAsync.when(
                data: (isOnline) => _InfoRow(
                  label: 'Status',
                  value: isOnline ? 'Online' : 'Offline',
                  valueColor: isOnline ? AppColors.success : AppColors.error,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Unknown'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Actions ───────────────────────────────────────────────────────
          _SectionCard(
            title: 'Actions',
            children: [
              _ActionTile(
                icon: Icons.sync_rounded,
                iconColor: AppColors.primary,
                title: 'Sync now',
                subtitle: 'Upload pending call logs to server',
                onTap: () {
                  ref.read(syncProvider.notifier).sync();
                  Navigator.pop(context);
                },
              ),
              Divider(color: colors.divider, height: 1),
              _ActionTile(
                icon: Icons.refresh_rounded,
                iconColor: AppColors.incoming,
                title: 'Refresh call logs',
                subtitle: 'Re-fetch logs from your phone',
                onTap: () {
                  ref.read(deviceSyncProvider.notifier).syncFromDevice();
                  Navigator.pop(context);
                },
              ),
              Divider(color: colors.divider, height: 1),
              syncSummaryAsync.maybeWhen(
                data: (s) => s.totalFailed > 0
                    ? Column(
                        children: [
                          _ActionTile(
                            icon: Icons.replay_rounded,
                            iconColor: AppColors.syncFailed,
                            title: 'Retry failed (${s.totalFailed})',
                            subtitle: 'Reset failed logs and retry on next sync',
                            onTap: () async {
                              final repo = ref.read(callLogRepositoryProvider);
                              await repo.retryFailed();
                              ref.invalidate(syncSummaryProvider);
                              ref.read(syncProvider.notifier).sync();
                              if (context.mounted) Navigator.pop(context);
                            },
                          ),
                          Divider(color: colors.divider, height: 1),
                        ],
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Call Log Settings ─────────────────────────────────────────────
          _SectionCard(
            title: 'Call Log Settings',
            children: [
              fetchDaysAsync.when(
                data: (days) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(label: 'Fetch range', value: '$days days'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [30, 60, 90, 180].map((d) {
                        final isSelected = days == d;
                        return GestureDetector(
                          onTap: () => ref
                              .read(callLogFetchDaysProvider.notifier)
                              .setDays(d),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : colors.surfaceVariant,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : colors.border,
                              ),
                            ),
                            child: Text(
                              '${d}d',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : colors.textSecondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Changes apply on next refresh',
                      style: TextStyle(color: colors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── About ─────────────────────────────────────────────────────────
          const _SectionCard(
            title: 'About',
            children: [
              _InfoRow(label: 'App', value: AppConstants.appName),
              _InfoRow(label: 'Version', value: AppConstants.appVersion),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}

// ── Section card ──────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Divider(color: colors.divider, height: 0),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

// ── Action tile ───────────────────────────────────────────────────────────────

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title),
      subtitle: Text(subtitle,
          style: TextStyle(color: colors.textSecondary, fontSize: 13)),
      trailing: Icon(Icons.chevron_right_rounded, color: colors.textMuted),
      onTap: onTap,
    );
  }
}

// ── Info row ──────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(color: colors.textSecondary, fontSize: 14)),
          Text(value,
              style: TextStyle(
                  color: valueColor ?? colors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
