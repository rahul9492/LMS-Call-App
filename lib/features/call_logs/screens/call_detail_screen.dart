import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/call_type_helpers.dart';
import '../../../data/models/call_log_model.dart';
import '../../../core/extensions/datetime_extensions.dart';

class CallDetailScreen extends ConsumerWidget {
  final CallLogGroup group;

  const CallDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = group.contactName ?? group.phoneNumber;
    final initials = CallTypeHelpers.initials(displayName);
    final typeColor = CallTypeHelpers.colorForType(group.lastCallType);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero header ──────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.surface,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: AppColors.textPrimary,
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.copy_rounded),
                color: AppColors.textSecondary,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: group.phoneNumber));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Number copied')),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      typeColor.withValues(alpha: 0.15),
                      AppColors.surface,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 28),
                      // Avatar
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: typeColor.withValues(alpha: 0.4), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: TextStyle(
                              color: typeColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          displayName,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (group.contactName != null) ...[
                        const SizedBox(height: 4),
                        GestureDetector(
                          onLongPress: () {
                            Clipboard.setData(
                                ClipboardData(text: group.phoneNumber));
                          },
                          child: Text(
                            group.phoneNumber,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _StatChip(
                            label: '${group.totalCalls}',
                            sublabel: 'Calls',
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          _StatChip(
                            label: '${group.missedCount}',
                            sublabel: 'Missed',
                            color: AppColors.missed,
                          ),
                          const SizedBox(width: 12),
                          _StatChip(
                            label: _totalDuration(group.calls),
                            sublabel: 'Total',
                            color: AppColors.incoming,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Action buttons ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.call_rounded,
                      label: 'Call',
                      color: AppColors.incoming,
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Dialer coming soon')),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.message_rounded,
                      label: 'Message',
                      color: AppColors.primary,
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('SMS coming soon')),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.person_add_rounded,
                      label: 'Add contact',
                      color: AppColors.accent,
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add contact coming soon')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Call history list ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  const Text(
                    'Call History',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${group.totalCalls}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final call = group.calls[index];
                return _CallHistoryItem(call: call);
              },
              childCount: group.calls.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  String _totalDuration(List<CallLogModel> calls) {
    final total = calls.fold<int>(0, (sum, c) => sum + c.durationSeconds);
    return total.secondsToCallDuration;
  }
}

// ── Stat chip ────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final String sublabel;
  final Color color;

  const _StatChip({
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          Text(
            sublabel,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action button ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Call history item ─────────────────────────────────────────────────────────

class _CallHistoryItem extends StatelessWidget {
  final CallLogModel call;

  const _CallHistoryItem({required this.call});

  @override
  Widget build(BuildContext context) {
    final color = CallTypeHelpers.colorForType(call.callType);
    final icon = CallTypeHelpers.iconForType(call.callType);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CallTypeHelpers.fullLabelForType(call.callType),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  call.timestamp.dateTimeFormatted,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (call.durationSeconds > 0)
                Text(
                  call.durationSeconds.secondsToCallDuration,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              if (call.ringDurationSeconds > 0)
                Text(
                  call.ringDurationSeconds.secondsToRingDuration,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              const SizedBox(height: 4),
              _SyncBadge(status: call.syncStatus),
            ],
          ),
        ],
      ),
    );
  }

}

// ── Sync badge ────────────────────────────────────────────────────────────────

class _SyncBadge extends StatelessWidget {
  final SyncStatus status;

  const _SyncBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    IconData icon;
    switch (status) {
      case SyncStatus.pending:
        color = AppColors.syncPending;
        label = 'Pending';
        icon = Icons.schedule_rounded;
        break;
      case SyncStatus.syncing:
        color = AppColors.info;
        label = 'Syncing';
        icon = Icons.sync_rounded;
        break;
      case SyncStatus.synced:
        color = AppColors.syncSynced;
        label = 'Synced';
        icon = Icons.check_circle_rounded;
        break;
      case SyncStatus.failed:
        color = AppColors.syncFailed;
        label = 'Failed';
        icon = Icons.error_rounded;
        break;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 12),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
