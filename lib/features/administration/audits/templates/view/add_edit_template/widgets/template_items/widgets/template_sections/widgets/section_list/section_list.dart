import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SectionListView extends StatelessWidget {
  const SectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: grey,
        ),
      ),
      child: BlocBuilder<TemplateDesignerBloc, TemplateDesignerState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SummaryView(),
              const CustomDivider(height: 1),
              for (int index = 0;
                  index < state.templateSectionList.length;
                  index++)
                SectionItemView(
                  section: state.templateSectionList[index],
                  active: state.selectedTemplateSection == state.templateSectionList[index],
                  first: index == 0,
                )
            ],
          );
        },
      ),
    );
  }
}
