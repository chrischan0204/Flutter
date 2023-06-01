import '/common_libraries.dart';

class DeleteFilterSettingItemButton extends StatefulWidget {
  final UserFilterItem userFilterItem;
  const DeleteFilterSettingItemButton({
    super.key,
    required this.userFilterItem,
  });

  @override
  State<DeleteFilterSettingItemButton> createState() =>
      _DeleteFilterSettingItemButtonState();
}

class _DeleteFilterSettingItemButtonState
    extends State<DeleteFilterSettingItemButton> {
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
        onClick: () => filterSettingBloc.add(
          FilterSettingUserFilterItemDeleted(
              userFilterItem: widget.userFilterItem),
        ),
        icon: const Icon(
          PhosphorIcons.x,
          color: Colors.red,
          size: 20,
        ),
      ),
    );
  }
}
