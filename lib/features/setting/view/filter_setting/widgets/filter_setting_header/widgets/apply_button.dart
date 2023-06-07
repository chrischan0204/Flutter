import '/common_libraries.dart';

class ApplyButton extends StatefulWidget {
  final ValueChanged<String> onFilterApplied;
  const ApplyButton({
    super.key,
    required this.onFilterApplied,
  });

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return ButtonTheme(
          minWidth: 120,
          child: ElevatedButton(
            onPressed: state.isNew || state.isFilterUpdateNotFill
                ? null
                : () {
                    widget.onFilterApplied(state.userFilterUpdate.id);
                    filterSettingBloc.add(
                      FilterSettingAppliedUserFilterSettingChanged(
                        appliedUserFilterSetting:
                            state.selectedUserFilterSetting!,
                      ),
                    );

                    if (!(state.selectedUserFilterSetting?.isNew ?? true)) {
                      CustomNotification(
                        context: context,
                        notifyType: NotifyType.success,
                        content:
                            'Filter "${state.selectedUserFilterSetting?.filterName}" is applied.',
                      ).showNotification();
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: successColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.regular.check,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 5),
                const Text(
                  'Apply',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
