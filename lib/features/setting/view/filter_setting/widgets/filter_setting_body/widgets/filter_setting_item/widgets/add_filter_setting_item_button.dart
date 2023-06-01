import '/common_libraries.dart';

class AddFilterSettingItemButton extends StatefulWidget {
  final UserFilterItem userFilterItem;
  const AddFilterSettingItemButton({
    super.key,
    required this.userFilterItem,
  });

  @override
  State<AddFilterSettingItemButton> createState() =>
      _AddFilterSettingItemButtonState();
}

class _AddFilterSettingItemButtonState
    extends State<AddFilterSettingItemButton> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: CustomIconButton(
        onClick: () => filterSettingBloc.add(FilterSettingUserFilterItemAdded(
            userFilterItem: widget.userFilterItem)),
        icon: const Icon(
          PhosphorIcons.plus,
          color: Colors.green,
          size: 20,
        ),
      ),
    );
  }
}
