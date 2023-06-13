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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
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
}
