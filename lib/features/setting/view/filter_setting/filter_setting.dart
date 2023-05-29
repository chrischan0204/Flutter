import 'package:flutter_animate/flutter_animate.dart';

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
    filterSettingBloc = context.read();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return Card(
          elevation: 3,
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 2 / 5),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterSettingHeaderView(
                    viewName: widget.viewName,
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
                            onFilterSaved: (filterId) {
                              widget.onFilterSaved(filterId);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
            .slideY();
      },
    );
  }
}
