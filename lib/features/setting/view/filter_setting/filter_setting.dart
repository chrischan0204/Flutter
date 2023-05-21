import '/common_libraries.dart';
import 'widgets/widgets.dart';

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
    return FilterSettingWidget(
      viewName: widget.viewName,
      onFilterOptionClosed: widget.onFilterOptionClosed,
      onFilterSaved: widget.onFilterSaved,
      onFilterApplied: widget.onFilterApplied,
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
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
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
                          const AddClauseButton(),
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
}
