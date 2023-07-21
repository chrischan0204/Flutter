import '/common_libraries.dart';

class ApplyButton extends StatelessWidget {
  final Function(String, [bool?]) onFilterApplied;
  final bool showOnlyIcon;
  const ApplyButton({
    super.key,
    required this.onFilterApplied,
    this.showOnlyIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return ButtonTheme(
          minWidth: 120,
          child: Tooltip(
            message: showOnlyIcon ? 'Apply' : '',
            child: ElevatedButton(
              onPressed: state.isFilterUpdateNotFill
                  ? null
                  : () {
                      context.read<FilterSettingBloc>().add(
                            FilterSettingAppliedUserFilterSettingChanged(
                              appliedUserFilterSetting:
                                  state.selectedUserFilterSetting?.isNew == true
                                      ? state.selectedUserFilterSetting!
                                          .copyWith(
                                              filterName: 'Unsaved filter')
                                      : state.selectedUserFilterSetting!,
                            ),
                          );

                      onFilterApplied(state.userFilterUpdate!.id, true);

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
                  if (!showOnlyIcon) const SizedBox(width: 5),
                  if (!showOnlyIcon)
                    const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
