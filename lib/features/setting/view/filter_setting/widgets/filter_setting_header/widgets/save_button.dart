import '/common_libraries.dart';

class SaveButton extends StatelessWidget {
  final ValueChanged<String> onFilterSaved;
  final bool showOnlyIcon;
  const SaveButton({
    super.key,
    required this.onFilterSaved,
    this.showOnlyIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return BlocListener<FilterSettingBloc, FilterSettingState>(
          listener: (context, state) {
            if (state.userFilterSettingUpdateStatus.isSuccess) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.success,
                content: 'User filter saved successfully',
              ).showNotification();
              onFilterSaved(state.userFilterUpdate.id);
              context.read<FilterSettingBloc>().add(
                  FilterSettingAppliedUserFilterSettingChanged(
                      appliedUserFilterSetting:
                          state.selectedUserFilterSetting!));
            }
          },
          listenWhen: (previous, current) =>
              previous.userFilterSettingUpdateStatus !=
              current.userFilterSettingUpdateStatus,
          child: Tooltip(
            message: showOnlyIcon ? 'Save' : '',
            child: ElevatedButton(
              onPressed: state.isNew || state.isFilterUpdateNotFill
                  ? null
                  : () {
                      if (Validation.isEmpty(
                          state.userFilterUpdate.filterName)) {
                        CustomNotification(
                          context: context,
                          notifyType: NotifyType.error,
                          content: 'Please fill the filter name',
                        ).showNotification();
                      } else {
                        context
                            .read<FilterSettingBloc>()
                            .add(const FilterSettingUserFilterSettingSaved());
                      }
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
              child: Row(
                children: [
                  Icon(
                    PhosphorIcons.regular.floppyDisk,
                    color: Colors.white,
                    size: 18,
                  ),
                  if (!showOnlyIcon) const SizedBox(width: 5),
                  if (!showOnlyIcon)
                    const Text(
                      'Save',
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
