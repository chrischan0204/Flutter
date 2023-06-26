import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uuid/uuid.dart';

import '/common_libraries.dart';

class ByQuestionCountView extends StatefulWidget {
  const ByQuestionCountView({super.key});

  @override
  State<ByQuestionCountView> createState() => _ByQuestionCountViewState();
}

class _ByQuestionCountViewState extends State<ByQuestionCountView> {
  late LabelIntersectAction _labelIntersectAction;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _labelIntersectAction = LabelIntersectAction.shift;
    _tooltipBehavior = TooltipBehavior(enable: true, header: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
      builder: (context, state) {
        return SfCircularChart(
          title: ChartTitle(text: 'By question count'),
          series: _getDefaultPieSeries(state.templateSnapshotList),
          tooltipBehavior: _tooltipBehavior,
        );
      },
    );
  }

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries(
      List<TemplateSnapshot> templateSnapList) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        explode: false,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: templateSnapList
            .map((templateSnapshot) => ChartSampleData(
                  pointColor: Color.fromARGB(
                    255,
                    Uuid.parse(templateSnapshot.id)[1],
                    Uuid.parse(templateSnapshot.id)[2],
                    Uuid.parse(templateSnapshot.id)[3],
                  ),
                  x: templateSnapshot.name,
                  y: templateSnapshot.questions,
                  text: '',
                ))
            .toList(),
        pointColorMapper: (datum, index) => datum.pointColor,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => ' ',
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(
          margin: EdgeInsets.zero,
          isVisible: false,
          connectorLineSettings: const ConnectorLineSettings(
            type: ConnectorType.curve,
            length: '20%',
          ),
          labelIntersectAction: _labelIntersectAction,
        ),
      ),
    ];
  }
}
