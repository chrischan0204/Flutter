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
    return SfCircularChart(
      title: ChartTitle(text: 'By Question Count'),
      series: _getDefaultPieSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        explode: false,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Cafe Supplies', y: 23, text: ''),
          ChartSampleData(x: 'Housekeeping', y: 14, text: ''),
          ChartSampleData(x: 'Electric', y: 35, text: ''),
          ChartSampleData(x: 'Signage', y: 28, text: ''),
        ],
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => data.x as String,
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(
          margin: EdgeInsets.zero,
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          connectorLineSettings: const ConnectorLineSettings(
              type: ConnectorType.curve, length: '20%'),
          labelIntersectAction: _labelIntersectAction,
        ),
      ),
    ];
  }
}
