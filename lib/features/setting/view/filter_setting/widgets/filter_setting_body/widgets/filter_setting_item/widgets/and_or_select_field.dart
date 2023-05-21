import '/common_libraries.dart';

class AndOrSelectField extends StatefulWidget {
  final bool isFirst;
  final UserFilterItem userFilterItem;
  const AndOrSelectField({
    super.key,
    required this.isFirst,
    required this.userFilterItem,
  });

  @override
  State<AndOrSelectField> createState() => _AndOrSelectFieldState();
}

class _AndOrSelectFieldState extends State<AndOrSelectField> {
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
