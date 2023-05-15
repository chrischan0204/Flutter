import 'widgets/add_filter_setting_item_button.dart';

import 'widgets/filter_setting_select_field.dart';

import '/common_libraries.dart';

class FilterSettingHeaderView extends StatelessWidget {
  final VoidCallback onFilterOptionClosed;
  const FilterSettingHeaderView({
    super.key,
    required this.onFilterOptionClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: IconButton(
                onPressed: () => onFilterOptionClosed(),
                icon: const Icon(PhosphorIcons.x, size: 18)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FilterSettingSelectField(),
                SizedBox(width: 20),
                AddFilterSettingItemButton()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
