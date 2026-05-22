import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/section_card.dart';
import '../../../sync/presentation/providers/sync_provider.dart';
import '../../../voucher/presentation/screens/voucher_reprint_preview_screen.dart';
import '../providers/parcel_list_provider.dart';
import '../widgets/parcel_list_item.dart';
import 'home_screen.dart';

class ParcelListScreen extends ConsumerStatefulWidget {
  const ParcelListScreen({super.key});

  static const routeName = '/parcels';

  @override
  ConsumerState<ParcelListScreen> createState() => _ParcelListScreenState();
}

class _ParcelListScreenState extends ConsumerState<ParcelListScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late final ProviderSubscription<ParcelListFilterState> _filterSubscription;

  Future<void> _handleRefresh() async {
    final result = await ref.read(syncProvider.notifier).syncNow();
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result.message)),
    );
  }

  @override
  void initState() {
    super.initState();
    final filters = ref.read(parcelListFilterProvider);
    _searchController = TextEditingController(text: filters.query);
    _searchFocusNode = FocusNode();
    _filterSubscription = ref.listenManual<ParcelListFilterState>(
      parcelListFilterProvider,
      (previous, next) {
        if (_searchController.text == next.query) {
          return;
        }

        _searchController.value = TextEditingValue(
          text: next.query,
          selection: TextSelection.collapsed(offset: next.query.length),
        );
      },
    );
  }

  @override
  void dispose() {
    _filterSubscription.close();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parcelsAsync = ref.watch(parcelListProvider);
    final filters = ref.watch(parcelListFilterProvider);
    final filterNotifier = ref.read(parcelListFilterProvider.notifier);
    final syncState = ref.watch(syncProvider);
    final selectedDate = filters.startDate;
    final hasActiveFilters =
        filters.query.trim().isNotEmpty ||
        filters.status != null ||
        filters.startDate != null ||
        filters.endDate != null;
    final searchCard = _SearchCard(
      controller: _searchController,
      focusNode: _searchFocusNode,
      selectedDate: selectedDate,
      onChanged: filterNotifier.updateQuery,
    );

    return AppScaffold(
      title: ParcelStrings.parcelListTitle,
      drawer: const AppDrawer(currentRoute: ParcelListScreen.routeName),
      canPop: false,
      onBackNavigation: () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      },
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          tooltip: syncState.isRunning
              ? AppStrings.syncingAction
              : AppStrings.syncNowAction,
          onPressed: syncState.isRunning
              ? null
              : () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final result = await ref.read(syncProvider.notifier).syncNow();
                  if (!mounted) {
                    return;
                  }
                  messenger.showSnackBar(
                    SnackBar(content: Text(result.message)),
                  );
                },
          icon: syncState.isRunning
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  Icons.cloud_sync_outlined,
                  color: syncState.status == SyncRunStatus.synced
                      ? AppColors.syncSynced
                      : syncState.status == SyncRunStatus.failed
                      ? AppColors.syncFailed
                      : null,
                ),
        ),
        IconButton(
          tooltip: selectedDate == null
              ? ParcelStrings.filterByDateTooltip
              : ParcelStrings.changeDateFilterTooltip,
          onPressed: () => _pickDate(context, filterNotifier, selectedDate),
          icon: Icon(
            selectedDate == null
                ? Icons.calendar_today_outlined
                : Icons.event_available_rounded,
          ),
        ),
        if (selectedDate != null || filters.query.isNotEmpty)
          IconButton(
            tooltip: ParcelStrings.clearFiltersTooltip,
            onPressed: filterNotifier.clearFilters,
            icon: const Icon(Icons.filter_alt_off),
          ),
      ],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity, child: searchCard),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.south_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      AppStrings.syncPullHint,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: parcelsAsync.when(
                data: (parcels) {
                  if (parcels.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        0,
                        AppSpacing.md,
                        AppSpacing.md,
                      ),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: AppEmptyState(
                              title: hasActiveFilters
                                  ? ParcelStrings.noMatchingParcelsTitle
                                  : ParcelStrings.noParcelsYetTitle,
                              message: hasActiveFilters
                                  ? ParcelStrings.noMatchingParcelsMessage
                                  : ParcelStrings.noParcelsYetMessage,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    itemCount: parcels.length,
                    separatorBuilder: (_, index) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final parcel = parcels[index];
                      return ParcelListItem(
                        parcel: parcel,
                        onTap: () {
                          if (parcel.id != null) {
                            Navigator.of(context).pushNamed(
                              VoucherReprintPreviewScreen.routeName,
                              arguments: parcel.id,
                            );
                          }
                        },
                      );
                    },
                  );
                },
                loading: () => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(
                      height: 240,
                      child: Center(child: AppLoading()),
                    ),
                  ],
                ),
                error: (error, _) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 240,
                      child: Center(
                        child: AppErrorView(message: error.toString()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    ParcelListFilterNotifier filterNotifier,
    DateTime? selectedDate,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked == null) {
      return;
    }

    filterNotifier.updateDateRange(
      startDate: DateTime(
        picked.year,
        picked.month,
        picked.day,
      ),
      endDate: DateTime(
        picked.year,
        picked.month,
        picked.day,
        23,
        59,
        59,
        999,
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.controller,
    required this.focusNode,
    required this.selectedDate,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final DateTime? selectedDate;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: selectedDate == null
                ? ParcelStrings.searchHint
                : ParcelStrings.filteredSearchHint,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: selectedDate == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.md),
                    child: Center(
                      widthFactor: 1,
                      child: Text(
                        '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
