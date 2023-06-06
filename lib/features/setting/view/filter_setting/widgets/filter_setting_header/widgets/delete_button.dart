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
                    filterSettingBloc.add(
                        FilterSettingUserFilterSettingDeletedById(
                            filterId: state.userFilterUpdate.id));
                  },
            style: ElevatedButton.styleFrom(
                backgroundColor: lightRed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
            child: Row(
              children: const [
                Icon(
                  PhosphorIcons.trash,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
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
