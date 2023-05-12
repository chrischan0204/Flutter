import '/common_libraries.dart';

class FilterSettingSelectField extends StatefulWidget {
  const FilterSettingSelectField({super.key});

  @override
  State<FilterSettingSelectField> createState() =>
      _FilterSettingSelectFieldState();
}

class _FilterSettingSelectFieldState extends State<FilterSettingSelectField> {
  late FilterSettingBloc filterSettingBloc;

  @override
  void initState() {
    filterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSettingBloc, FilterSettingState>(
      builder: (context, state) => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Filter',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Builder(
                builder: (context) {
                  Map<String, UserFilterSetting> items = {};
                  for (var userFilterSetting in state.userFilterSettingList) {
                    items.addEntries([
                      MapEntry(userFilterSetting.filterName, userFilterSetting)
                    ]);
                  }
                  return SizedBox(
                    child: CustomSingleSelect(
                      selectedValue:
                          state.selectedUserFilterSetting?.filterName,
                      items: items,
                      hint: 'Select Filter',
                      onChanged: (value) {
                        filterSettingBloc.add(
                            FilterSettingUserFilterSettingSelected(
                                userFilterSetting: value.value));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
