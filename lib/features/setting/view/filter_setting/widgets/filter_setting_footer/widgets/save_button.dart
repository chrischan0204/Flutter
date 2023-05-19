import '/common_libraries.dart';

class SaveButton extends StatefulWidget {
  final ValueChanged<String> onFilterSaved;
  const SaveButton({
    super.key,
    required this.onFilterSaved,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
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
        return BlocListener<FilterSettingBloc, FilterSettingState>(
          listener: (context, state) {
            if (state.userFilterSettingUpdateStatus.isSuccess) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.success,
                content: 'User filter saved successfully',
              ).showNotification();
              widget.onFilterSaved(state.userFilterUpdate.id);
            }
          },
          listenWhen: (previous, current) =>
              previous.userFilterSettingUpdateStatus !=
              current.userFilterSettingUpdateStatus,
          child: ElevatedButton(
            onPressed: state.isNew || state.isFilterUpdateNotFill
                ? null
                : () {
                    if (Validation.isEmpty(state.userFilterUpdate.filterName)) {
                      CustomNotification(
                        context: context,
                        notifyType: NotifyType.error,
                        content: 'Please fill the filter name',
                      ).showNotification();
                    } else {
                      filterSettingBloc
                          .add(FilterSettingUserFilterSettingUpdated());
                    }
                  },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
