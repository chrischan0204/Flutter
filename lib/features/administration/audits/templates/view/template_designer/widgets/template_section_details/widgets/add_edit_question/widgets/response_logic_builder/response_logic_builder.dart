import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ResponseLogicBuilder extends StatelessWidget {
  final bool child;
  final TemplateSectionItem templateSectionItem;
  final List<TemplateSectionItem> templateSectionItemList;
  const ResponseLogicBuilder({
    super.key,
    required this.child,
    required this.templateSectionItem,
    this.templateSectionItemList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Response logic builder',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            const CustomDivider(),
            ResponseLogicBuilderNameView(
              templateSectionItem: templateSectionItem,
            ),
            if (templateSectionItemList.isNotEmpty)
              const ResponseLogicBuilderHeader(),
            Column(
                mainAxisSize: MainAxisSize.min,
                children: templateSectionItemList
                    .map((templateSectionItem) => ResponseScaleItemView(
                          response: templateSectionItem.response?.name ?? '',
                          child: child,
                          templateSectionItem: templateSectionItem,
                        ))
                    .toList())
          ],
        ),
      ),
    );
  }
}
