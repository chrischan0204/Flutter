import '../../../../../../../template_detail/widgets/template_view/widgets/widgets.dart';
import '/common_libraries.dart';
import 'widgets/widgets.dart';

class SummarySectionView extends StatefulWidget {
  const SummarySectionView({super.key});

  @override
  State<SummarySectionView> createState() => _SummarySectionViewState();
}

class _SummarySectionViewState extends State<SummarySectionView> {
  @override
  void initState() {
    context.read<TemplateDetailBloc>().add(TemplateDetailSnapshotLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, state) {
            if (state.templateSnapshotList.isNotEmpty) {
              return const Row(
                children: [
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
            }
            return Center(
              child: Padding(
                padding: insety30,
                child: Text(
                  'Data will be displayed once sections and question are created.',
                  style: textSemiBold14,
                ),
              ),
            );
          },
        ),
        const CustomDivider(height: 1),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: UsageView(),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: EditRulesView(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
