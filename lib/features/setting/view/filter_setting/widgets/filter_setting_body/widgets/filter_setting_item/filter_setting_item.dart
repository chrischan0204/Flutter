import '/common_libraries.dart';
import 'widgets/widgets.dart';

class FilterSettingItemView extends StatefulWidget {
  final bool isFirst;
  final List<FilterSetting> filterSettingList;
  final UserFilterItem userFilterItem;
  const FilterSettingItemView({
    super.key,
    this.isFirst = false,
    this.filterSettingList = const [],
    required this.userFilterItem,
  });

  @override
  State<FilterSettingItemView> createState() => _FilterSettingItemViewState();
}

class _FilterSettingItemViewState extends State<FilterSettingItemView> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(5),
        color: lightTeal,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AddFilterSettingItemButton(userFilterItem: widget.userFilterItem),
          DeleteFilterSettingItemButton(userFilterItem: widget.userFilterItem),
          const SizedBox(width: 5),
          AndOrSelectField(
            isFirst: widget.isFirst,
            userFilterItem: widget.userFilterItem,
          ),
          const SizedBox(width: 5),
          ColumnSelectField(
            userFilterItem: widget.userFilterItem,
            filterSettingList: widget.filterSettingList,
          ),
          const SizedBox(width: 5),
          OperatorSelectField(userFilterItem: widget.userFilterItem),
          const SizedBox(width: 5),
          ValueField(userFilterItem: widget.userFilterItem),
        ],
      ),
    );
  }
}
