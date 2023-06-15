import '/common_libraries.dart';

class OperatorSelectField extends StatefulWidget {
  final UserFilterItem userFilterItem;
  const OperatorSelectField({
    super.key,
    required this.userFilterItem,
  });

  @override
  State<OperatorSelectField> createState() => _OperatorSelectFieldState();
}

class _OperatorSelectFieldState extends State<OperatorSelectField> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  Map<String, String> _getOperator() {
    Map<String, String> map = const {
      '=': '=',
      '<': '<',
      '<=': '<=',
      '>': '>',
      '>=': '>=',
      '!=': '!=',
    };
    switch (widget.userFilterItem.filterSetting.controlType) {
      case 'Textbox':
        if (widget.userFilterItem.filterSetting.columnType == 'Numeric') {
          return {
            ...map,
            'IN': 'IN',
            'Not In': 'Not In',
          };
        }
        return {
          ...map,
          'Contains': 'Contains',
          'Not Contains': 'Not Contains',
          'IN': 'IN',
          'Not In': 'Not In',
        };
      case 'DateTimePicker':
        return map;
      case 'DatePicker':
        return map;
      case 'Select':
        return {
          ...map,
          'IN': 'IN',
          'Not In': 'Not In',
        };
    }

    return {
      ...map,
      'Contains': 'Contains',
      'Not Contains': 'Not Contains',
      'IN': 'IN',
      'Not In': 'Not In',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.userFilterItem.operator,
      preferBelow: false,
      child: SizedBox(
        width: 160,
        child: CustomSingleSelect(
          selectedValue: widget.userFilterItem.operator,
          items: _getOperator(),
          onChanged: (value) => filterSettingBloc.add(
              FilterSettingUserFilterItemOperatorChanged(
                  operator: value.value,
                  userFilterItem: widget.userFilterItem)),
        ),
      ),
    );
  }
}
