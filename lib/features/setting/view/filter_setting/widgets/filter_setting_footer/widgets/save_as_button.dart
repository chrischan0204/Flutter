import '/common_libraries.dart';

class SaveAsButton extends StatefulWidget {
  final ValueChanged<String> onFilterSaved;
  const SaveAsButton({
    super.key,
    required this.onFilterSaved,
  });

  @override
  State<SaveAsButton> createState() => _SaveAsButtonState();
}

class _SaveAsButtonState extends State<SaveAsButton> {
  late FilterSettingBloc filterSettingBloc;
  String saveAsName = '';

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isFilterUpdateNotFill
              ? null
              : () {
                  CustomAlert(
                    context: context,
                    width: MediaQuery.of(context).size.width / 4,
                    title: 'Save as',
                    description: 'Please enter the filter name.',
                    btnOkText: state.saveAsButtonName,
                    btnOkOnPress: () {
                      if (!Validation.isEmpty(saveAsName)) {
                        filterSettingBloc.add(
                            FilterSettingUserFilterSettingSavedAs(
                                saveAsName: saveAsName));
                      }
                    },
                    btnCancelOnPress: () {},
                    body: Column(
                      children: [
                        Text(
                          'Please enter the filter name to ${state.saveAsButtonName.toLowerCase()}.',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 20),
                        CustomTextField(
                          onChanged: (value) {
                            setState(() => saveAsName = value);
                          },
                        ),
                      ],
                    ),
                    dialogType: DialogType.info,
                  ).show();
                },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
          child: Text(
            state.saveAsButtonName,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
