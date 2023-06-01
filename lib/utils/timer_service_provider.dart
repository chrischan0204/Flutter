import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/common_libraries.dart';

class TimerServiceProvider extends InheritedWidget {
  final TimerService service;
  const TimerServiceProvider({
    super.key,
    required super.child,
    required this.service,
  });

  @override
  bool updateShouldNotify(TimerServiceProvider oldWidget) =>
      service != oldWidget.service;
}

class TimerService extends ChangeNotifier {
  Timer? _timer;

  Duration get currentDuration => _currentDuration;
  final Duration _currentDuration = Duration.zero;

  bool get isRunning => _timer != null;

  void _logout(Timer timer) {
    stop();
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(
        Duration(minutes: int.parse(dotenv.env['EXPIRATION_TIME'] ?? '120')),
        _logout);
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    stop();
    start();
  }

  static TimerService of(BuildContext context) {
    final TimerServiceProvider? provider =
        context.dependOnInheritedWidgetOfExactType<TimerServiceProvider>();
    return provider!.service;
  }
}
