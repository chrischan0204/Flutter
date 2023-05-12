import 'widgets/add_filter_setting_item_button.dart';

import 'widgets/filter_setting_select_field.dart';

import '/common_libraries.dart';

class FilterSettingHeaderView extends StatelessWidget {
  const FilterSettingHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FilterSettingSelectField(),
          SizedBox(width: 20),
          AddFilterSettingItemButton()
          // Expanded(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       // ElevatedButton(
          //       //   onPressed: () {
          //       //     if (state.selectedUserFilterSetting != null) {
          //       //       filterSettingBloc.add(
          //       //           FilterSettingUserFilterSettingLoadedById(
          //       //               filterId: state.selectedUserFilterSetting!.id));
          //       //     }
          //       //   },
          //       //   style: ElevatedButton.styleFrom(
          //       //     shape: RoundedRectangleBorder(
          //       //       borderRadius: BorderRadius.circular(3),
          //       //     ),
          //       //   ),
          //       //   child: const Text(
          //       //     'Load',
          //       //     style: TextStyle(
          //       //       color: Colors.white,
          //       //       fontSize: 14,
          //       //     ),
          //       //   ),
          //       // ),
          //       const SizedBox(width: 20),

          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
