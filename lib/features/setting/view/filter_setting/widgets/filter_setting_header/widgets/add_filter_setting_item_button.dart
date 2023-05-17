import '/common_libraries.dart';

class AddFilterSettingItemButton extends StatefulWidget {
  const AddFilterSettingItemButton({super.key});

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
    return ElevatedButton(
      onPressed: () => filterSettingBloc
          .add(const FilterSettingUserFilterAdded(viewName: 'user')),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: const Text(
        'Add',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
