import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/call_type_helpers.dart';
import '../../../data/models/call_log_model.dart';
import '../../../core/extensions/datetime_extensions.dart';

class CallLogGroupTile extends ConsumerWidget {
  final CallLogGroup group;
  final VoidCallback onTap;

  const CallLogGroupTile({
    super.key,
    required this.group,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (group.calls.isEmpty) return const SizedBox.shrink();

    final lastCall = group.calls.first;
    final callColor = CallTypeHelpers.colorForType(group.lastCallType);
    final callIcon = CallTypeHelpers.iconForType(group.lastCallType);
    final displayName = group.contactName ?? group.phoneNumber;
    final initials = CallTypeHelpers.initials(displayName);
    final isMissed = group.lastCallType == CallTypeEnum.missed;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: callColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: TextStyle(
                        color: callColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Call type badge
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: callColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                    child: Icon(callIcon, color: Colors.white, size: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            // Name + number + type
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          displayName,
                          style: TextStyle(
                            color: isMissed
                                ? AppColors.missed
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (group.totalCalls > 1)
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
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
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(callIcon, size: 13, color: callColor),
                      const SizedBox(width: 4),
                      Text(
                        CallTypeHelpers.labelForType(group.lastCallType),
                        style: TextStyle(
                          color: callColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('·',
                          style: TextStyle(
                              color: AppColors.textMuted, fontSize: 12)),
                      const SizedBox(width: 6),
                      if (lastCall.durationSeconds > 0) ...[
                        Text(
                          lastCall.durationSeconds.secondsToCallDuration,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('·',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 12)),
                        const SizedBox(width: 6),
                      ],
                      Flexible(
                        child: Text(
                          timeago.format(lastCall.timestamp, locale: 'en_short'),
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Sync dot
            _SyncDot(status: lastCall.syncStatus),
            const SizedBox(width: 4),
            // Call back icon
            IconButton(
              icon: const Icon(Icons.call_rounded),
              color: AppColors.primary,
              iconSize: 22,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dialer coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SyncDot extends StatelessWidget {
  final SyncStatus status;

  const _SyncDot({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String tooltip;
    switch (status) {
      case SyncStatus.pending:
        color = AppColors.syncPending;
        tooltip = 'Pending sync';
        break;
      case SyncStatus.syncing:
        color = AppColors.info;
        tooltip = 'Syncing…';
        break;
      case SyncStatus.synced:
        color = AppColors.syncSynced;
        tooltip = 'Synced';
        break;
      case SyncStatus.failed:
        color = AppColors.syncFailed;
        tooltip = 'Sync failed';
        break;
    }
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
