import 'widgets/filter_setting_select_field.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class FilterSettingHeaderView extends StatelessWidget {
  final VoidCallback onFilterOptionClosed;
  final String viewName;
  final ValueChanged<String> onFilterApplied;
  const FilterSettingHeaderView({
    super.key,
    required this.onFilterOptionClosed,
    required this.onFilterApplied,
    required this.viewName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FilterSettingSelectField(viewName: viewName),
              const SizedBox(width: 30),
              const IsDefaultSwitch(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ApplyButton(onFilterApplied: onFilterApplied),
              const SizedBox(width: 20),
              SaveButton(onFilterSaved: onFilterApplied),
              const SizedBox(width: 20),
              SaveAsButton(onFilterSaved: onFilterApplied),
              const SizedBox(width: 20),
              RenameButton(onFilterSaved: onFilterApplied),
              const SizedBox(width: 20),
              const DeleteButton(),
              const SizedBox(width: 20),
              IconButton(
                  onPressed: () => onFilterOptionClosed(),
                  icon: Icon(PhosphorIcons.regular.x, size: 14))
            ],
          ),
        ],
      ),
    );
  }
}
