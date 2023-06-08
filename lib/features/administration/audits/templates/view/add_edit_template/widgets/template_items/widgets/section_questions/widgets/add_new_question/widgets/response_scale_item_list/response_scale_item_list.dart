import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ResponseScaleItemListView extends StatelessWidget {
  final int responseScaleId;
  final int level;
  const ResponseScaleItemListView({
    super.key,
    required this.level,
    required this.responseScaleId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // children: templateSectionItemList
      //     .map((templateSectionItem) => ResponseScaleItemView(
      //           response: templateSectionItem.response?.name ?? '',
      //           level: level,
      //           templateSectionItem: templateSectionItem,
      //         ))
      //     .toList(),
    );
  }
}
