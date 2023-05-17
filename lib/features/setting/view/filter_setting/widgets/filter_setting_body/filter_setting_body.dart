import '../filter_setting_item.dart';

import '/common_libraries.dart';

class FilterSettingBodyView extends StatefulWidget {
  final String viewName;
  const FilterSettingBodyView({
    super.key,
    required this.viewName,
  });

  @override
  State<FilterSettingBodyView> createState() => _FilterSettingBodyViewState();
}

class _FilterSettingBodyViewState extends State<FilterSettingBodyView> {
  late FilterSettingBloc filterSettingBloc;
  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterSettingBloc, FilterSettingState>(
      listener: (context, state) {
        filterSettingBloc.add(
            FilterSettingUserFilterSettingListLoaded(name: widget.viewName));
      },
      listenWhen: (previous, current) =>
          previous.userFilterSettingDeleteStatus !=
          current.userFilterSettingDeleteStatus,
      builder: (context, state) => Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        // constraints:
        //     BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 4, minHeight: 52 * 5),
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  children: const [
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      child: Text('Action'),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: Text('And/Or'),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Text('Field'),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 150,
                      child: Text('Operator'),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Text('Value'),
                    ),
                  ],
                ),
              ),
              ...state.userFilterUpdate.undeletedUserFilterItems.map(
                (userFilterItem) {
                  return FilterSettingItemView(
                    isFirst: state.userFilterUpdate.undeletedUserFilterItems
                            .indexOf(userFilterItem) ==
                        0,
                    filterSettingList: state.filterSettingList,
                    userFilterItem: userFilterItem,
                  );
                },
              ).toList()
            ],
          ),
        ),
      ),
    );
  }
}
