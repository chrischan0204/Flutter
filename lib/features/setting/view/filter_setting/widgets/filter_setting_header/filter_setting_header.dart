import 'widgets/filter_setting_select_field.dart';

import '/common_libraries.dart';

class FilterSettingHeaderView extends StatelessWidget {
  final VoidCallback onFilterOptionClosed;
  final String viewName;
  const FilterSettingHeaderView({
    super.key,
    required this.onFilterOptionClosed,
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
          Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: FilterSettingSelectField(viewName: viewName),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () => onFilterOptionClosed(),
                icon: const Icon(PhosphorIcons.x, size: 14)),
          ),
        ],
      ),
    );
  }
}
