import '/common_libraries.dart';

class RenameButton extends StatefulWidget {
  final ValueChanged<String> onFilterSaved;
  const RenameButton({
    super.key,
    required this.onFilterSaved,
  });

  @override
  State<RenameButton> createState() => _RenameButtonState();
}

class _RenameButtonState extends State<RenameButton> {
  late FilterSettingBloc filterSettingBloc;
  TextEditingController filterNameController = TextEditingController();
  String saveAsName = '';

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  void dispose() {
    filterNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isNew || state.isFilterUpdateNotFill
              ? null
              : () {
                  filterNameController.text = state.userFilterUpdate.filterName;
                  CustomAlert(
                    context: context,
                    width: MediaQuery.of(context).size.width / 4,
                    title: 'Rename the filter',
                    description: 'Please enter the filter name.',
                    btnOkText: 'Rename',
                    btnOkOnPress: () {
                      if (!Validation.isEmpty(
                          state.userFilterUpdate.filterName)) {
                        filterSettingBloc
                            .add(const FilterSettingUserFilterSettingSaved());
                      } else {
                        CustomNotification(
                          context: context,
                          notifyType: NotifyType.error,
                          content: 'Please fill the filter name',
                        ).showNotification();
                      }
                    },
                    btnCancelOnPress: () {},
                    body: Column(
                      children: [
                        const Text(
                          'Please enter the filter name to rename.',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 20),
                        CustomTextField(
                          controller: filterNameController,
                          onChanged: (value) {
                            filterSettingBloc.add(
                                FilterSettingUserFilterNameChanged(
                                    filterName: value));
                          },
                        ),
                      ],
                    ),
                    dialogType: DialogType.info,
                  ).show();
                },
          style: ElevatedButton.styleFrom(
              backgroundColor: warnColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
          child: Row(
            children: [
              Icon(
                PhosphorIcons.regular.pencil,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 5),
              const Text(
                'Rename',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
