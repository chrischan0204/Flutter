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
            // style: ButtonStyle(
            //   backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            //   overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
            // ),
            style: ElevatedButton.styleFrom(
              backgroundColor: lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            child: Row(
              children: const [
                Icon(
                  PhosphorIcons.check,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
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
