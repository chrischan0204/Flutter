import '/common_libraries.dart';

class IsDefaultSwitch extends StatelessWidget {
  const IsDefaultSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSwitch(
              switchValue: state.userFilterUpdate.isDefault,
              onChanged: (value) => context.read<FilterSettingBloc>().add(
                  FilterSettingUserFilterIsDefaultChanged(isDefault: value)),
              onlySwitch: true,
            ),
            const SizedBox(width: 10),
            const Text('Default', style: TextStyle(fontSize: 14)),
          ],
        );
      },
    );
  }
}
