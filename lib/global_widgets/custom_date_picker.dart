import 'package:intl/intl.dart';

import '/common_libraries.dart';
import 'package:star_menu/star_menu.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialSelectedDate;
  final ValueChanged<DateTime> onChanged;
  final TextEditingController controller;
  const CustomDatePicker({
    super.key,
    this.initialSelectedDate,
    required this.onChanged,
    required this.controller,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final Color monthCellBackground = lightTeal;
  final Color indicatorColor = const Color(0xFF1AC4C7);
  final Color highlightColor = Colors.blueAccent;
  final Color cellTextColor = const Color(0xFF130438);

  @override
  void initState() {
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        widget.controller.text =
            DateFormat('yyyy-MM-dd').format((args.value as DateTime));
        widget.onChanged(args.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StarMenu(
      params: StarMenuParameters.dropdown(context).copyWith(
          centerOffset: Offset(
              MediaQuery.of(context).size.width > 1250 ? 300 : 240,
              MediaQuery.of(context).size.width > 1250 ? 130 : 115)),
      items: [
        Padding(
          key: UniqueKey(),
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width > 1250 ? 400 : 300,
            height: MediaQuery.of(context).size.width > 1250 ? 520 : 400,
            child:
                // SfDateRangePicker(
                //   onSelectionChanged: _onSelectionChanged,
                //   selectionMode: DateRangePickerSelectionMode.single,
                //   initialSelectedDate: widget.initialSelectedDate,
                // )
                SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              onSelectionChanged: _onSelectionChanged,
              initialSelectedDate: widget.initialSelectedDate,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionColor: highlightColor,
              selectionTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 14),
              minDate: DateTime.now().add(const Duration(days: -200)),
              maxDate: DateTime.now().add(const Duration(days: 500)),
              headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: cellTextColor,
                  )),
              monthCellStyle: DateRangePickerMonthCellStyle(
                  cellDecoration: _MonthCellDecoration(
                      backgroundColor: monthCellBackground,
                      showIndicator: false,
                      indicatorColor: indicatorColor),
                  todayCellDecoration: _MonthCellDecoration(
                      borderColor: highlightColor,
                      backgroundColor: monthCellBackground,
                      showIndicator: false,
                      indicatorColor: indicatorColor),
                  specialDatesDecoration: _MonthCellDecoration(
                      backgroundColor: monthCellBackground,
                      showIndicator: true,
                      indicatorColor: indicatorColor),
                  disabledDatesTextStyle: const TextStyle(
                    color: Color(0xffe2d7fe),
                  ),
                  weekendTextStyle: TextStyle(
                    color: highlightColor,
                  ),
                  textStyle: TextStyle(color: cellTextColor, fontSize: 14),
                  specialDatesTextStyle:
                      TextStyle(color: cellTextColor, fontSize: 14),
                  todayTextStyle:
                      TextStyle(color: highlightColor, fontSize: 14)),
              yearCellStyle: DateRangePickerYearCellStyle(
                todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
                textStyle: TextStyle(color: cellTextColor, fontSize: 14),
                disabledDatesTextStyle:
                    const TextStyle(color: Color(0xffe2d7fe)),
                leadingDatesTextStyle: TextStyle(
                    color: cellTextColor.withOpacity(0.5), fontSize: 14),
              ),
              showNavigationArrow: true,
              todayHighlightColor: highlightColor,
              monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                        fontSize: 10,
                        color: cellTextColor,
                        fontWeight: FontWeight.w600)),
                dayFormat: 'EEE',
              ),
            ),
          ),
        ),
      ],
      child: SizedBox(
        width: double.infinity,
        child: CustomTextField(controller: widget.controller),
      ),
    );
  }
}

class _MonthCellDecoration extends Decoration {
  const _MonthCellDecoration(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MonthCellDecorationPainter(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor);
  }
}

/// [_MonthCellDecorationPainter] used to paint month cell decoration.
class _MonthCellDecorationPainter extends BoxPainter {
  _MonthCellDecorationPainter(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    final Paint paint = Paint()..color = backgroundColor!;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    if (borderColor != null) {
      paint.color = borderColor!;
      canvas.drawRRect(
          RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    }

    if (showIndicator) {
      paint.color = indicatorColor!;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bounds.right - 6, bounds.top + 6), 2.5, paint);
    }
  }
}
