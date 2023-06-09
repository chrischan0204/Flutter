import 'package:syncfusion_flutter_charts/charts.dart';

import '/common_libraries.dart';

class ByMaxPointsView extends StatefulWidget {
  const ByMaxPointsView({super.key});

  @override
  State<ByMaxPointsView> createState() => _ByQuestionCountViewState();
}

class _ByQuestionCountViewState extends State<ByMaxPointsView> {
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
          title: ChartTitle(text: 'By Question Count'),
          series: _getDefaultPieSeries(state.templateSnapshotList),
          tooltipBehavior: _tooltipBehavior,
        );
      },
    );
  }

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries(
      List<TemplateSnapshot> templateSnapshotList) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        explode: false,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: templateSnapshotList
            .map((templateSnapshot) => ChartSampleData(
                x: templateSnapshot.name,
                y: templateSnapshot.maxScore,
                text: ''))
            .toList(),
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y == 0 ? 1 : data.y,
        dataLabelMapper: (ChartSampleData data, _) => ' ',
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(
          margin: EdgeInsets.zero,
          isVisible: true,
          labelPosition: ChartDataLabelPosition.inside,
          connectorLineSettings: const ConnectorLineSettings(
              type: ConnectorType.curve, length: '20%'),
          labelIntersectAction: _labelIntersectAction,
        ),
      ),
    ];
  }
}
