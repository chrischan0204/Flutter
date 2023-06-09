import 'package:flutter_animate/flutter_animate.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class FilterSettingView extends StatefulWidget {
  final String viewName;
  final VoidCallback onFilterOptionClosed;
  final ValueChanged<String> onFilterSaved;
  final Function(String, [bool?]) onFilterApplied;
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
  final Function(String, [bool?]) onFilterApplied;
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
                maxHeight: MediaQuery.of(context).size.height / 3),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilterSettingHeaderView(
                        viewName: widget.viewName,
                        onFilterApplied: widget.onFilterApplied,
                        onFilterOptionClosed: () =>
                            setState(() => widget.onFilterOptionClosed()),
                      ),
                      const CustomDivider(),
                      const FilterSettingItemHeader(),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Builder(
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
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilterSettingBodyView(viewName: widget.viewName),
                            const AddClauseButton(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, curve: Curves.easeOutQuad)
            .slideY(begin: -.05);
      },
    );
  }
}
