import '/common_libraries.dart';
import 'template_section_item.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class ExistingTemplateSections extends StatefulWidget {
  const ExistingTemplateSections({super.key});

  @override
  State<ExistingTemplateSections> createState() =>
      _ExistingTemplateSectionsState();
}

class _ExistingTemplateSectionsState extends State<ExistingTemplateSections> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
        builder: (context, state) {
          return ReorderableList(
            onReorder: (_, __) {
              return true;
            },
            onReorderDone: (draggedItem) {
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return TemplateSectionItemView(
                          key: ValueKey(state.templateSectionList[index].id),
                          templateSection: state.templateSectionList[index],
                          templateSectionItemCount: state
                              .templateSectionList[index]
                              .templateSectionItemCount,
                          isFirst: index == 0,
                          isLast: index == state.templateSectionList.length - 1,
                        );
                      },
                      childCount: state.templateSectionList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
