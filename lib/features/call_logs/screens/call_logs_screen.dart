import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/call_log_model.dart';
import '../providers/call_log_providers.dart';
import '../../sync/providers/sync_providers.dart';
import '../widgets/call_log_tile.dart';

class CallLogsScreen extends ConsumerStatefulWidget {
  const CallLogsScreen({super.key});

  @override
  ConsumerState<CallLogsScreen> createState() => _CallLogsScreenState();
}

class _CallLogsScreenState extends ConsumerState<CallLogsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Trigger device sync on first open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncProvider.notifier).sync();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final syncState = ref.watch(syncProvider);
    final filterState = ref.watch(activeCallFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildAppBar(syncState, innerBoxIsScrolled),
          _buildSyncBanner(),
          _buildFilterBar(filterState),
        ],
        body: _buildCallLogList(),
      ),
      floatingActionButton: _buildSyncFab(syncState),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────

  Widget _buildAppBar(AsyncValue syncState, bool innerBoxIsScrolled) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: false,
      backgroundColor: AppColors.surface,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.phone_in_talk_rounded,
                color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          const Text(
            'LMS Call',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        // Connectivity indicator
        Consumer(
          builder: (context, ref, _) {
            final online = ref.watch(isOnlineProvider);
            return online.when(
              data: (isOnline) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  isOnline ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                  color: isOnline ? AppColors.success : AppColors.textMuted,
                  size: 20,
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          },
        ),
        // Sync status
        if (syncState.isLoading)
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.search_rounded),
          color: AppColors.textSecondary,
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.search),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          color: AppColors.textSecondary,
          onPressed: () => _showOptionsMenu(context),
        ),
      ],
    );
  }

  // ── Sync status banner ────────────────────────────────────────────────────

  Widget _buildSyncBanner() {
    return SliverToBoxAdapter(
      child: Consumer(
        builder: (context, ref, _) {
          final summary = ref.watch(syncSummaryProvider);
          return summary.when(
            data: (s) {
              if (!s.hasUnsynced) return const SizedBox.shrink();
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.syncPending.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.syncPending.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sync_rounded,
                        color: AppColors.syncPending, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${s.totalPending} call${s.totalPending == 1 ? '' : 's'} pending sync'
                        '${s.totalFailed > 0 ? ' • ${s.totalFailed} failed' : ''}',
                        style: const TextStyle(
                          color: AppColors.syncPending,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          ref.read(syncProvider.notifier).sync(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Sync now',
                        style: TextStyle(
                          color: AppColors.syncPending,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  // ── Filter chips ──────────────────────────────────────────────────────────

  Widget _buildFilterBar(CallFilter activeFilter) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _FilterBarDelegate(
        child: Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: CallFilter.values.map((f) {
                final isActive = f == activeFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_filterLabel(f)),
                    selected: isActive,
                    onSelected: (_) => ref
                        .read(activeCallFilterProvider.notifier)
                        .setFilter(f),
                    backgroundColor: AppColors.surfaceVariant,
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    checkmarkColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isActive ? AppColors.primary : AppColors.textSecondary,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 13,
                    ),
                    side: BorderSide(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.border,
                      width: isActive ? 1.5 : 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // ── Call log list ─────────────────────────────────────────────────────────

  Widget _buildCallLogList() {
    return Consumer(
      builder: (context, ref, _) {
        final filteredAsync = ref.watch(filteredCallLogsProvider);
        return filteredAsync.when(
          data: (groups) => groups.isEmpty
              ? _buildEmptyState()
              : _buildGroupedList(groups),
          loading: () => _buildShimmerList(),
          error: (e, _) => _buildErrorState(e),
        );
      },
    );
  }

  Widget _buildGroupedList(List<CallLogGroup> groups) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.card,
      onRefresh: () => ref.read(syncProvider.notifier).sync(),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 8, bottom: 100),
        itemCount: groups.length,
        separatorBuilder: (_, __) => const Divider(
          height: 0.5,
          indent: 82,
          color: AppColors.divider,
        ),
        itemBuilder: (context, index) {
          final group = groups[index];
          return CallLogGroupTile(
            group: group,
            onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.callDetail,
              arguments: group,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.phone_missed_rounded,
              color: AppColors.textMuted,
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No call logs found',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pull down to refresh or tap sync\nto load your call history.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(syncProvider.notifier).sync(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariant,
      highlightColor: AppColors.card,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const CircleAvatar(radius: 26, backgroundColor: Colors.white),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 14,
                        width: 140,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 6)),
                    Container(height: 12, width: 200, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── FAB ───────────────────────────────────────────────────────────────────

  Widget _buildSyncFab(AsyncValue syncState) {
    return FloatingActionButton.extended(
      onPressed: syncState.isLoading
          ? null
          : () => ref.read(syncProvider.notifier).sync(),
      backgroundColor: AppColors.primary,
      icon: syncState.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2),
            )
          : const Icon(Icons.sync_rounded, color: Colors.white),
      label: Text(
        syncState.isLoading ? 'Syncing…' : 'Sync',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ── Options menu ──────────────────────────────────────────────────────────

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.settings_rounded,
                  color: AppColors.textSecondary),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AppRoutes.settings);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.sync_rounded, color: AppColors.textSecondary),
              title: const Text('Force sync now'),
              onTap: () {
                Navigator.pop(context);
                ref.read(syncProvider.notifier).sync();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _filterLabel(CallFilter f) {
    switch (f) {
      case CallFilter.all:
        return 'All';
      case CallFilter.incoming:
        return 'Incoming';
      case CallFilter.outgoing:
        return 'Outgoing';
      case CallFilter.missed:
        return 'Missed';
    }
  }
}

// ── Filter bar delegate ───────────────────────────────────────────────────

class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _FilterBarDelegate({required this.child});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant _FilterBarDelegate oldDelegate) =>
      oldDelegate.child != child;
}
