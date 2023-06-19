import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ResponseScaleItemListView extends StatelessWidget {
  final List<TemplateSectionItem> templateSectionItemList;
  const ResponseScaleItemListView({
    super.key,
    this.templateSectionItemList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (templateSectionItemList.isNotEmpty)
          const ResponseScaleItemListHeaderView(),
        for (final templateSectionItem in templateSectionItemList)
          ResponseScaleItemView(
            templateSectionItem: templateSectionItem,
          ),
      ],
    );
  }
}
