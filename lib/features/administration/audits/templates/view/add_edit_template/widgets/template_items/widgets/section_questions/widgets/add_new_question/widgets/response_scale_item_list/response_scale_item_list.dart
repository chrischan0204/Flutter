import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ResponseScaleItemListView extends StatelessWidget {
  final int level;
  final List<TemplateSectionItem> templateSectionItemList;
  const ResponseScaleItemListView({
    super.key,
    required this.level,
    this.templateSectionItemList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ResponseScaleItemListHeaderView(),
        for (final templateSectionItem in templateSectionItemList)
          ResponseScaleItemView(
            response: templateSectionItem.response?.name ?? '',
            level: level,
            templateSectionItem: templateSectionItem,
          ),
      ],
    );
  }
}
