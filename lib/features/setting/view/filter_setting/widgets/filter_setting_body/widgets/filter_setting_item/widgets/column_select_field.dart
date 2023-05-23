import '/common_libraries.dart';

class ColumnSelectField extends StatefulWidget {
  final UserFilterItem userFilterItem;
  final List<FilterSetting> filterSettingList;
  const ColumnSelectField({
    super.key,
    required this.userFilterItem,
    required this.filterSettingList,
  });

  @override
  State<ColumnSelectField> createState() => _ColumnSelectFieldState();
}

class _ColumnSelectFieldState extends State<ColumnSelectField> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Builder(builder: (context) {
        Map<String, FilterSetting> items = {};
        for (var filterSetting in widget.filterSettingList) {
          items
              .addEntries([MapEntry(filterSetting.columnTitle, filterSetting)]);
        }
        return CustomSingleSelect(
          hint: 'Select Column',
          items: items,
          selectedValue: widget.userFilterItem.filterSetting.columnTitle,
          onChanged: (value) => filterSettingBloc.add(
              FilterSettingUserFilterItemColumnChanged(
                  column: value.value, userFilterItem: widget.userFilterItem)),
        );
      }),
    );
  }
}
