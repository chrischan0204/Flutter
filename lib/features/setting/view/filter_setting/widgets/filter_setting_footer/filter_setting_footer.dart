import '/common_libraries.dart';

class FilterSettingFooterView extends StatefulWidget {
  const FilterSettingFooterView({super.key});

  @override
  State<FilterSettingFooterView> createState() =>
      _FilterSettingFooterViewState();
}

class _FilterSettingFooterViewState extends State<FilterSettingFooterView> {
  late FilterSettingBloc filterSettingBloc;
  TextEditingController filterNameController = TextEditingController();

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
          previous.userFilterUpdate.id != current.userFilterUpdate.id,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 150,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filter Name', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 200,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocListener<FilterSettingBloc, FilterSettingState>(
                    listener: (context, state) {
                      if (state.userFilterSettingUpdateStatus.isSuccess) {
                        CustomNotification(
                          context: context,
                          notifyType: NotifyType.success,
                          content: 'User filter saved successfully',
                        ).showNotification();
                      }
                    },
                    listenWhen: (previous, current) =>
                        previous.userFilterSettingUpdateStatus !=
                        current.userFilterSettingUpdateStatus,
                    child: ElevatedButton(
                      onPressed: () {
                        if (Validation.isEmpty(
                            state.userFilterUpdate.filterName)) {
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
                  ),
                  const SizedBox(width: 20),
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
