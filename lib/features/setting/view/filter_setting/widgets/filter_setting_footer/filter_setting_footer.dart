import '/common_libraries.dart';
import 'widgets/widgets.dart';

class FilterSettingFooterView extends StatelessWidget {
  final ValueChanged<String> onFilterSaved;
  final ValueChanged<String> onFilterApplied;
  final VoidCallback onFilterOptionClosed;
  final String viewName;
  const FilterSettingFooterView({
    super.key,
    required this.onFilterSaved,
    required this.onFilterApplied,
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
          const Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: FilterInfo(),
          ),
          const SizedBox(width: 30),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ApplyButton(onFilterApplied: onFilterApplied),
                const SizedBox(width: 20),
                SaveButton(onFilterSaved: onFilterApplied),
                const SizedBox(width: 20),
                SaveAsButton(onFilterSaved: onFilterApplied),
                const SizedBox(width: 20),
                const DeleteButton(),
                const SizedBox(width: 20),
                CancelButton(onFilterOptionClosed: onFilterOptionClosed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
