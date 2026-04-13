import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/call_type_helpers.dart';
import '../../../core/utils/intent_utils.dart';
import '../../../data/models/call_log_model.dart';
import '../providers/call_log_providers.dart';
import '../../../core/extensions/datetime_extensions.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: colors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: TextStyle(color: colors.textPrimary, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Search by name or number…',
            hintStyle: TextStyle(color: colors.textMuted),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_rounded),
              color: colors.textSecondary,
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _query.isEmpty ? _buildEmptyPrompt() : _buildResults(),
    );
  }

  Widget _buildEmptyPrompt() {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, color: colors.textMuted, size: 56),
          const SizedBox(height: 16),
          Text(
            'Search call logs',
            style: TextStyle(
                color: colors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            'Enter a name or phone number',
            style: TextStyle(color: colors.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    final colors = context.colors;
    final groupsAsync = ref.watch(groupedCallLogsProvider);
    return groupsAsync.when(
      data: (groups) {
        final matched = groups.where((g) {
          final name = (g.contactName ?? '').toLowerCase();
          final number = g.phoneNumber.toLowerCase();
          return name.contains(_query) || number.contains(_query);
        }).toList();

        if (matched.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off_rounded, color: colors.textMuted, size: 48),
                const SizedBox(height: 16),
                Text(
                  'No results for "$_query"',
                  style: TextStyle(color: colors.textSecondary, fontSize: 15),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 8, bottom: 32),
          itemCount: matched.length,
          separatorBuilder: (_, __) => Divider(
            height: 0.5,
            indent: 82,
            color: colors.divider,
          ),
          itemBuilder: (context, i) => _SearchResultTile(group: matched[i]),
        );
      },
      loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(
          child: Text(e.toString(),
              style: const TextStyle(color: AppColors.error))),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final CallLogGroup group;
  const _SearchResultTile({required this.group});

  @override
  Widget build(BuildContext context) {
    if (group.calls.isEmpty) return const SizedBox.shrink();
    final colors = context.colors;
    final lastCall = group.calls.first;
    final color = CallTypeHelpers.colorForType(group.lastCallType);
    final icon = CallTypeHelpers.iconForType(group.lastCallType);
    final displayName = group.contactName ?? group.phoneNumber;

    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(AppRoutes.callDetail, arguments: group),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  CallTypeHelpers.initials(displayName),
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: TextStyle(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(icon, size: 12, color: color),
                      const SizedBox(width: 4),
                      Text(
                        CallTypeHelpers.labelForType(group.lastCallType),
                        style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${lastCall.timestamp.dateTimeFormatted}',
                        style:
                            TextStyle(color: colors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.call_rounded),
              color: AppColors.primary,
              iconSize: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              onPressed: () =>
                  IntentUtils.launchDialer(context, group.phoneNumber),
            ),
          ],
        ),
      ),
    );
  }
}
