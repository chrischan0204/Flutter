import '/common_libraries.dart';
import 'widgets/widgets.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class SectionListView extends StatefulWidget {
  const SectionListView({
    super.key,
  });

  @override
  State<SectionListView> createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView> {
  bool _reorderCallback(Key item, Key newPosition) {
    context
        .read<TemplateDesignerBloc>()
        .add(TemplateDesignerTemplateSectionListSorted(
          currentQuestionId: item,
          newIndex: newPosition,
        ));
    return true;
  }

  void _reorderDone(Key item) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: grey,
        ),
      ),
      child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
        builder: (context, state) {
          if (state.templateSectionListLoadStatus.isLoading) {
            return const Center(child: Loader());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SummaryView(),
              const CustomDivider(height: 1),
              SizedBox(
                height: 50.0 * state.templateSectionList.length,
                child: ReorderableList(
                  onReorder: _reorderCallback,
                  onReorderDone: _reorderDone,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return SectionItemView(
                                section: state.templateSectionList[index],
                                active: state.selectedTemplateSection ==
                                    state.templateSectionList[index],
                                first: index == 0,
                                last: index ==
                                    state.templateSectionList.length - 1,
                              );
                            },
                            childCount: state.templateSectionList.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
