import '/common_libraries.dart';

class InactivityDetectWidget extends StatefulWidget {
  final Widget? child;
  final Function(BuildContext) onShouldNavigate;
  const InactivityDetectWidget({
    super.key,
    required this.child,
    required this.onShouldNavigate,
  });

  @override
  State<InactivityDetectWidget> createState() => _InactivityDetectWidgetState();
}

class _InactivityDetectWidgetState extends State<InactivityDetectWidget> {
  TimerService? _timerService;
  @override
  Widget build(BuildContext context) {
    if (_timerService == null) {
      _timerService = TimerService.of(context);
      _timerService!.start();
      _timerService!.addListener(_handleTimerNotifier);
    }

    return GestureDetector(
      onTap: _handleUserInteraction,
      onPanDown: _handleUserInteraction,
      onScaleStart: _handleUserInteraction,
      child: widget.child,
    );
  }

  void _handleUserInteraction([_]) {
    _timerService!.reset();
  }

  void _handleTimerNotifier() {
    widget.onShouldNavigate(context);
  }
}
