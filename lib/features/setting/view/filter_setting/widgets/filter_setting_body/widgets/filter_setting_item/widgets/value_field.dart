import 'package:date_time_picker/date_time_picker.dart';

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

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlType = widget.userFilterItem.filterSetting.controlType;
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: Builder(
        builder: (context) {
          switch (controlType) {
            case 'Textbox':
              return widget.userFilterItem.filterValue.isNotEmpty
                  ? CustomTextField(
                      key: ValueKey(widget.userFilterItem.filterSetting.columnTitle),
                      initialValue: widget.userFilterItem.filterValue[0],
                      onChanged: (value) => filterSettingBloc
                              .add(FilterSettingUserFilterItemValueChanged(
                            userFilterItem: widget.userFilterItem,
                            value: [value],
                          )))
                  : CustomTextField(
                      key: ValueKey(widget.userFilterItem.filterSetting.columnTitle),
                      initialValue: '',
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
                  items.addEntries(
                      [MapEntry(item, Entity(id: item, name: item))]);
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
            case 'BooleanBox':
              return widget.userFilterItem.filterValue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomSwitch(
                        switchValue:
                            widget.userFilterItem.filterValue[0] == 'True',
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        onChanged: (value) => filterSettingBloc.add(
                          FilterSettingUserFilterItemValueChanged(
                            userFilterItem: widget.userFilterItem,
                            value: [value ? 'True' : 'False'],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomSwitch(
                        switchValue: false,
                        trueString: 'Yes',
                        falseString: 'No',
                        textColor: darkTeal,
                        onChanged: (value) => filterSettingBloc.add(
                          FilterSettingUserFilterItemValueChanged(
                            userFilterItem: widget.userFilterItem,
                            value: [value ? 'True' : 'False'],
                          ),
                        ),
                      ),
                    );

            case 'DateTimePicker':
              return CustomDateTimePicker(
                key: UniqueKey(),
                initialValue: widget.userFilterItem.filterValue.isNotEmpty
                    ? widget.userFilterItem.filterValue[0]
                    : null,
                onChange: (date) => filterSettingBloc
                    .add(FilterSettingUserFilterItemValueChanged(
                  userFilterItem: widget.userFilterItem,
                  value: [date.toIso8601String()],
                )),
              );
            case 'DatePicker':
              return CustomDateTimePicker(
                key: UniqueKey(),
                dateTimePickerType: DateTimePickerType.date,
                initialValue: widget.userFilterItem.filterValue.isNotEmpty
                    ? widget.userFilterItem.filterValue[0]
                    : null,
                onChange: (date) => filterSettingBloc
                    .add(FilterSettingUserFilterItemValueChanged(
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
        },
      ),
    );
  }
}
