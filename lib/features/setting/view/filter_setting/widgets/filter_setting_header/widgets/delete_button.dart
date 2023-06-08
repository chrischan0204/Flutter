import '/common_libraries.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({super.key});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
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
            if (state.userFilterSettingDeleteStatus.isSuccess) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.success,
                content: 'User filter deleted successfully',
              ).showNotification();
            }
          },
          listenWhen: (previous, current) =>
              previous.userFilterSettingDeleteStatus !=
              current.userFilterSettingDeleteStatus,
          child: ElevatedButton(
            onPressed: state.isNew
                ? null
                : () {
                    CustomAlert(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      title: 'Confirm',
                      description: 'Do you really want to delete this filter?',
                      btnOkText: 'Remove',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        filterSettingBloc.add(
                            FilterSettingUserFilterSettingDeletedById(
                                filterId: state.userFilterUpdate.id));
                      },
                      dialogType: DialogType.question,
                    ).show();
                  },
            style: ElevatedButton.styleFrom(
                backgroundColor: dangerColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.regular.trash,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 5),
                const Text(
                  'Delete',
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
