import '/common_libraries.dart';

class AddClauseButton extends StatefulWidget {
  const AddClauseButton({super.key});

  @override
  State<AddClauseButton> createState() => _AddClauseButtonState();
}

class _AddClauseButtonState extends State<AddClauseButton> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextButton(
        onPressed: () =>
            filterSettingBloc.add(const FilterSettingUserFilterItemAdded()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              PhosphorIcons.plus,
              size: 16,
              color: Colors.green,
            ),
            SizedBox(width: 3),
            Text(
              'Add new clause',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
