import '/common_libraries.dart';

class FilterInfo extends StatefulWidget {
  const FilterInfo({super.key});

  @override
  State<FilterInfo> createState() => _FilterInfoState();
}

class _FilterInfoState extends State<FilterInfo> {
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
  void dispose() {
    filterNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterSettingBloc, FilterSettingState>(
      listener: (context, state) {
        filterNameController.text = state.userFilterUpdate.filterName;
        filterNameController.selection = TextSelection.collapsed(
            offset: state.userFilterUpdate.filterName.length);
      },
      listenWhen: (previous, current) =>
          previous.userFilterUpdate.filterName !=
          current.userFilterUpdate.filterName,
      builder: (context, state) {
        return Row(
          children: [
            const Text('Filter Name', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 20),
            Expanded(
              child: CustomTextField(
                  controller: filterNameController,
                  onChanged: (value) => filterSettingBloc.add(
                      FilterSettingUserFilterNameChanged(filterName: value))),
            ),
            const SizedBox(width: 20),
            CustomSwitch(
              switchValue: state.userFilterUpdate.isDefault,
              onChanged: (value) => filterSettingBloc.add(
                  FilterSettingUserFilterIsDefaultChanged(isDefault: value)),
              onlySwitch: true,
            ),
            const SizedBox(width: 10),
            const Text('Default', style: TextStyle(fontSize: 14)),
          ],
        );
      },
    );
  }
}
