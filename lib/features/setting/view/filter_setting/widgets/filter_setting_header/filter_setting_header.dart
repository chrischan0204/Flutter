import 'widgets/filter_setting_select_field.dart';

import '/common_libraries.dart';
import 'widgets/widgets.dart';

class FilterSettingHeaderView extends StatelessWidget {
  final VoidCallback onFilterOptionClosed;
  final String viewName;
  final Function(String, [bool?]) onFilterApplied;
  const FilterSettingHeaderView({
    super.key,
    required this.onFilterOptionClosed,
    required this.onFilterApplied,
    required this.viewName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Row(
            children: [
              FilterSettingSelectField(viewName: viewName),
              const SizedBox(width: 20),
              const IsDefaultSwitch(),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ApplyButton(onFilterApplied: onFilterApplied),
                const SizedBox(width: 10),
                SaveButton(onFilterSaved: onFilterApplied),
                const SizedBox(width: 10),
                SaveAsButton(onFilterSaved: onFilterApplied),
                const SizedBox(width: 10),
                RenameButton(onFilterSaved: onFilterApplied),
                const SizedBox(width: 10),
                const DeleteButton(),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => onFilterOptionClosed(),
                  child: Icon(PhosphorIcons.regular.x, size: 14),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
