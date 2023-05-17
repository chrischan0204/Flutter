import '/common_libraries.dart';

class FilterSettingFooterView extends StatefulWidget {
  final ValueChanged<String> onFilterSaved;
  final VoidCallback onFilterApplied;
  final VoidCallback onFilterOptionClosed;
  const FilterSettingFooterView({
    super.key,
    required this.onFilterSaved,
    required this.onFilterApplied,
    required this.onFilterOptionClosed,
  });

  @override
  State<FilterSettingFooterView> createState() =>
      _FilterSettingFooterViewState();
}

class _FilterSettingFooterViewState extends State<FilterSettingFooterView> {
  late FilterSettingBloc filterSettingBloc;
  TextEditingController filterNameController = TextEditingController();
  String saveAsName = '';

  @override
  void initState() {
    filterSettingBloc = context.read();
    filterNameController.text =
        filterSettingBloc.state.userFilterUpdate.filterName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterSettingBloc, FilterSettingState>(
      listener: (context, state) {
        filterNameController.text = state.userFilterUpdate.filterName;
      },
      listenWhen: (previous, current) =>
          previous.userFilterUpdate.filterName !=
          current.userFilterUpdate.filterName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Row(
                  children: [
                    const Text('Filter Name', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 30),
                    Expanded(
                      child: CustomTextField(
                          // initialValue: state.userFilterUpdate.filterName,
                          controller: filterNameController,
                          onChanged: (value) => filterSettingBloc.add(
                              FilterSettingUserFilterNameChanged(
                                  filterName: value))),
                    ),
                    const SizedBox(width: 20),
                    CustomSwitch(
                      switchValue: state.userFilterUpdate.isDefault,
                      onChanged: (value) => filterSettingBloc.add(
                          FilterSettingUserFilterIsDefaultChanged(
                              isDefault: value)),
                      onlySwitch: true,
                    ),
                    const SizedBox(width: 10),
                    const Text('Default', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocListener<FilterSettingBloc, FilterSettingState>(
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
                        onPressed: state.isNew
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
                                  filterSettingBloc.add(
                                      FilterSettingUserFilterSettingUpdated());
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3))),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
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
                    ),
                    // const SizedBox(width: 20),
                    // ElevatedButton(
                    //   onPressed: () => widget.onFilterApplied(),
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.green,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(3))),
                    //   child: const Text(
                    //     'Apply',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                    const SizedBox(width: 30),
                    BlocListener<FilterSettingBloc, FilterSettingState>(
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
                        onPressed: () {
                          filterSettingBloc.add(
                              FilterSettingUserFilterSettingDeletedById(
                                  filterId: state.userFilterUpdate.id));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3))),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        widget.onFilterOptionClosed();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3))),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
