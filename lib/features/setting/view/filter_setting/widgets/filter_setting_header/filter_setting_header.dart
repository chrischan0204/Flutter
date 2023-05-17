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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
                onPressed: () => onFilterOptionClosed(),
                icon: const Icon(PhosphorIcons.x, size: 18)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: FilterSettingSelectField(),
          ),
        ],
      ),
    );
  }
}
