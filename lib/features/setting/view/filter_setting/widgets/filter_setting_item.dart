import '/common_libraries.dart';

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
        vertical: 4,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAddButton(),
          _buildDeleteButton(),
          const SizedBox(width: 5),
          _buildAndOrSelectField(),
          const SizedBox(width: 5),
          _buildColumnSelectField(),
          const SizedBox(width: 5),
          _buildOperatorSelectField(),
          const SizedBox(width: 5),
          _buildValueField(),
        ],
      ),
    );
  }

  Flexible _buildValueField() {
    final controlType = widget.userFilterItem.filterSetting.controlType;
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: controlType == 'Textbox'
          ? widget.userFilterItem.filterValue.isNotEmpty
              ? CustomTextField(
                  initialValue: widget.userFilterItem.filterValue[0],
                  onChanged: (value) => filterSettingBloc
                          .add(FilterSettingUserFilterItemValueChanged(
                        userFilterItem: widget.userFilterItem,
                        value: [value],
                      )))
              : CustomTextField(
                  onChanged: (value) => filterSettingBloc
                          .add(FilterSettingUserFilterItemValueChanged(
                        userFilterItem: widget.userFilterItem,
                        value: [value],
                      )))
          : controlType == 'Select'
              ? Builder(builder: (context) {
                  Map<String, Entity> items = {};
                  for (final item
                      in widget.userFilterItem.filterSetting.columnValues) {
                    items.addEntries(
                        [MapEntry(item, Entity(id: item, name: item))]);
                  }
                  // return CustomSingleSelect(
                  //   hint: 'Select ${widget.userFilterItem.filterSetting.columnTitle}',
                  //   selectedValue: widget.userFilterItem.filterValue[0],
                  //   items: map,
                  // onChanged: (value) => filterSettingBloc
                  //     .add(FilterSettingUserFilterItemValueChanged(
                  //   userFilterItem: widget.userFilterItem,
                  //   value: value.key,
                  // )),
                  // );
                  return CustomMultiSelect(
                    items: items,
                    selectedItems: widget.userFilterItem.filterValue
                        .map((e) => Entity(id: e, name: e))
                        .toList(),
                    hint:
                        'Select ${widget.userFilterItem.filterSetting.columnTitle}',
                    onChanged: (projects) => filterSettingBloc
                        .add(FilterSettingUserFilterItemValueChanged(
                      userFilterItem: widget.userFilterItem,
                      value: projects.map((e) => e.name!).toList(),
                    )),
                  );
                })
              : Container(
                  width: double.infinity,
                  color: Colors.grey,
                ),
    );
  }

  SizedBox _buildOperatorSelectField() {
    return SizedBox(
      width: 150,
      child: CustomSingleSelect(
        selectedValue: widget.userFilterItem.operator,
        items: const {
          '=': '=',
          '<': '<',
          '<=': '<=',
          '>': '>',
          '>=': '>=',
          '!=': '!=',
          'Contains': 'Contains',
          'Not Contains': 'Not Contains',
          'IN': 'IN',
          'Not In': 'Not In',
        },
        onChanged: (value) => filterSettingBloc.add(
            FilterSettingUserFilterItemOperatorChanged(
                operator: value.value, userFilterItem: widget.userFilterItem)),
      ),
    );
  }

  Flexible _buildColumnSelectField() {
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

  SizedBox _buildDeleteButton() {
    return SizedBox(
      width: 50,
      child: IconButton(
        onPressed: () => filterSettingBloc.add(
            FilterSettingUserFilterItemDeleted(
                userFilterItem: widget.userFilterItem)),
        icon: const Icon(
          PhosphorIcons.x,
          color: Colors.red,
          size: 20,
        ),
      ),
    );
  }

  SizedBox _buildAddButton() {
    return SizedBox(
      width: 50,
      child: IconButton(
        onPressed: () => filterSettingBloc.add(FilterSettingUserFilterItemAdded(
            userFilterItem: widget.userFilterItem)),
        icon: const Icon(
          PhosphorIcons.plus,
          color: Colors.green,
          size: 20,
        ),
      ),
    );
  }

  SizedBox _buildAndOrSelectField() {
    return SizedBox(
      width: 100,
      child: widget.isFirst
          ? Container()
          : CustomSingleSelect(
              selectedValue: widget.userFilterItem.booleanCondition,
              items: const {'And': 'And', 'Or': 'Or'},
              onChanged: (value) => filterSettingBloc.add(
                  FilterSettingUserFilterItemBooleanConditionChanged(
                      booleanCondition: value.value,
                      userFilterItem: widget.userFilterItem)),
            ),
    );
  }
}
