import 'package:intl/intl.dart';

import '/common_libraries.dart';

class ValueField extends StatefulWidget {
  final UserFilterItem userFilterItem;
  const ValueField({
    super.key,
    required this.userFilterItem,
  });

  @override
  State<ValueField> createState() => _ValueFieldState();
}

class _ValueFieldState extends State<ValueField> {
  late FilterSettingBloc filterSettingBloc;
  TextEditingController dateTimePickerController = TextEditingController();

  @override
  void initState() {
    filterSettingBloc = context.read();
    if (widget.userFilterItem.filterSetting.controlType == 'DateTimePicker' &&
        widget.userFilterItem.filterValue.isNotEmpty) {
      dateTimePickerController.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.userFilterItem.filterValue[0]));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlType = widget.userFilterItem.filterSetting.controlType;
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: Builder(builder: (context) {
        switch (controlType) {
          case 'Textbox':
            return widget.userFilterItem.filterValue.isNotEmpty
                ? CustomTextField(
                    key: ValueKey(widget.userFilterItem.id),
                    initialValue: widget.userFilterItem.filterValue[0],
                    onChanged: (value) => filterSettingBloc
                            .add(FilterSettingUserFilterItemValueChanged(
                          userFilterItem: widget.userFilterItem,
                          value: [value],
                        )))
                : CustomTextField(
                    key: ValueKey(widget.userFilterItem.id),
                    onChanged: (value) => filterSettingBloc
                            .add(FilterSettingUserFilterItemValueChanged(
                          userFilterItem: widget.userFilterItem,
                          value: [value],
                        )));
          case 'Select':
            return Builder(builder: (context) {
              Map<String, Entity> items = {};
              for (final item
                  in widget.userFilterItem.filterSetting.columnValues) {
                items
                    .addEntries([MapEntry(item, Entity(id: item, name: item))]);
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
            });
          case 'BooleanBox':
            return Builder(builder: (context) {
              Map<String, Entity> items = {};
              for (final item in ['Yes', 'No']) {
                items
                    .addEntries([MapEntry(item, Entity(id: item, name: item))]);
              }

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
            });

          case 'DateTimePicker':
            return CustomDatePicker(
              key: UniqueKey(),
              controller: dateTimePickerController,
              initialSelectedDate: widget.userFilterItem.filterValue.isNotEmpty
                  ? DateTime.parse(widget.userFilterItem.filterValue[0])
                  : null,
              onChanged: (date) =>
                  filterSettingBloc.add(FilterSettingUserFilterItemValueChanged(
                userFilterItem: widget.userFilterItem,
                value: [date.toIso8601String()],
              )),
            );
          default:
            return Container(
              width: double.infinity,
              color: Colors.grey,
            );
        }
      }),
    );
  }
}
