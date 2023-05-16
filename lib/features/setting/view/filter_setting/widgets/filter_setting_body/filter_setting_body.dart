import '../filter_setting_item.dart';

import '/common_libraries.dart';

class FilterSettingBodyView extends StatefulWidget {
  const FilterSettingBodyView({super.key});

  @override
  State<FilterSettingBodyView> createState() => _FilterSettingBodyViewState();
}

class _FilterSettingBodyViewState extends State<FilterSettingBodyView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 4),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: state.userFilterUpdate.undeletedUserFilterItems.map(
              (userFilterItem) {
                return FilterSettingItemView(
                  isFirst: state.userFilterUpdate.undeletedUserFilterItems
                          .indexOf(userFilterItem) ==
                      0,
                  filterSettingList: state.filterSettingList,
                  userFilterItem: userFilterItem,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
