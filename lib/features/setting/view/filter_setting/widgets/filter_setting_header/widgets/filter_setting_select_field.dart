import '/common_libraries.dart';

class FilterSettingSelectField extends StatefulWidget {
  final String viewName;
  const FilterSettingSelectField({
    super.key,
    required this.viewName,
  });

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
      builder: (context, state) => Row(
        children: [
          const Text(
            'Select Filter',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 20),
          Builder(
            builder: (context) {
              Map<String, dynamic> items = {'Add New': 'Add New'};
              for (var userFilterSetting in state.userFilterSettingList) {
                items.addEntries([
                  MapEntry(userFilterSetting.filterName, userFilterSetting)
                ]);
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 5,
                  minWidth: 150,
                ),
                child: CustomSingleSelect(
                  selectedValue:
                      state.selectedUserFilterSetting?.filterName ?? 'Unsaved filter',
                  items: items,
                  hint: 'Select Filter',
                  onChanged: (value) {
                    if (value.value is UserFilterSetting) {
                      filterSettingBloc.add(
                          FilterSettingUserFilterSettingSelected(
                              userFilterSetting: value.value));
                    } else {
                      filterSettingBloc.add(
                          FilterSettingUserFilterSettingNewAdded(
                              viewName: widget.viewName));
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
