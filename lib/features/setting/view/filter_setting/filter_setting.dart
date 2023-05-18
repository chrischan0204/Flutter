import 'widgets/filter_setting_body/filter_setting_body.dart';
import 'widgets/filter_setting_footer/filter_setting_footer.dart';
import 'widgets/filter_setting_header/filter_setting_header.dart';

import '/common_libraries.dart';

class FilterSettingView extends StatefulWidget {
  final String viewName;
  final VoidCallback onFilterOptionClosed;
  final ValueChanged<String> onFilterSaved;
  final ValueChanged<String> onFilterApplied;
  const FilterSettingView({
    super.key,
    required this.viewName,
    required this.onFilterOptionClosed,
    required this.onFilterSaved,
    required this.onFilterApplied,
  });

  @override
  State<FilterSettingView> createState() => _FilterSettingViewState();
}

class _FilterSettingViewState extends State<FilterSettingView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => SettingsRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => FilterSettingBloc(
                      settingsRepository: RepositoryProvider.of(context))),
            ],
            child: FilterSettingWidget(
              viewName: widget.viewName,
              onFilterOptionClosed: widget.onFilterOptionClosed,
              onFilterSaved: widget.onFilterSaved,
              onFilterApplied: widget.onFilterApplied,
            ),
          ),
        );
      },
    );
  }
}

class FilterSettingWidget extends StatefulWidget {
  final String viewName;
  final VoidCallback onFilterOptionClosed;
  final ValueChanged<String> onFilterSaved;
  final ValueChanged<String> onFilterApplied;
  const FilterSettingWidget({
    super.key,
    required this.viewName,
    required this.onFilterOptionClosed,
    required this.onFilterSaved,
    required this.onFilterApplied,
  });

  @override
  State<FilterSettingWidget> createState() => _FilterSettingWidgetState();
}

class _FilterSettingWidgetState extends State<FilterSettingWidget> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read()
      ..add(FilterSettingFilterSettingListLoaded(name: widget.viewName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterSettingBloc, FilterSettingState>(
      listener: (context, state) {
        if (state.filterSettingListLoadStatus.isSuccess) {
          filterSettingBloc.add(
              FilterSettingUserFilterSettingListLoaded(name: widget.viewName));
        }
      },
      listenWhen: (previous, current) =>
          previous.filterSettingListLoadStatus !=
          current.filterSettingListLoadStatus,
      builder: (context, state) {
        return Column(
          children: [
            const CustomDivider(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterSettingHeaderView(
                    onFilterOptionClosed: () =>
                        setState(() => widget.onFilterOptionClosed()),
                  ),
                  const CustomDivider(),
                  Builder(
                    builder: (context) {
                      if (state.userFilterSettingList.isEmpty &&
                          state.userFilterUpdate.undeletedUserFilterItems
                              .isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'There are no user filter settings. Please click Add Button to create new user filter setting',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FilterSettingBodyView(viewName: widget.viewName),
                          _buildAddClauseButton(),
                          const CustomDivider(),
                          FilterSettingFooterView(
                            viewName: widget.viewName,
                            onFilterOptionClosed: widget.onFilterOptionClosed,
                            onFilterApplied: widget.onFilterApplied,
                            onFilterSaved: (filterId) =>
                                widget.onFilterSaved(filterId),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Padding _buildAddClauseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextButton(
        onPressed: () =>
            filterSettingBloc.add(const FilterSettingUserFilterItemAdded()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              PhosphorIcons.plus,
              size: 16,
              color: Colors.green,
            ),
            SizedBox(width: 3),
            Text(
              'Add new clause',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
