import '/common_libraries.dart';
import 'widgets/widgets.dart';

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
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) => Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FilterSettingItemHeader(),
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
