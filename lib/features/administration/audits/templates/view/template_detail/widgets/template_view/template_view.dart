import '/common_libraries.dart';

import 'widgets/widgets.dart';

class TemplateView extends StatelessWidget {
  const TemplateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, state) {
            return TemplateDetailHeaderView(
                title: 'Template for ${state.template?.name ?? ''}');
          },
        ),
        const CustomDivider(),
        BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, state) {
            if (state.templateSnapshotListLoadStatus.isLoading) {
              return const Center(child: Loader());
            }
            if (state.templateSnapshotList.isNotEmpty) {
              return LayoutBuilder(builder: (context, constraints) {
                return Row(
                  children: const [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: TemplateSectionView(),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: CategoryWeightView(),
                    )
                  ],
                );
              });
            }
            return Center(
              child: Text(
                'Data will be displayed once sections and questions are created',
                style: textSemiBold14,
              ),
            );
          },
        ),
        const CustomDivider(),
        const SummaryView(),
      ],
    );
  }
}
