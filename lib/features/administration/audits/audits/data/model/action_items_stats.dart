import 'dart:convert';

import 'package:equatable/equatable.dart';

class ActionItemsStats extends Equatable {
  final int total;
  final int open;
  final int closed;

  const ActionItemsStats({
    required this.total,
    required this.open,
    required this.closed,
  });

  @override
  List<Object?> get props => [
        total,
        open,
        closed,
      ];

  factory ActionItemsStats.fromMap(Map<String, dynamic> map) {
    return ActionItemsStats(
      total: map['total'] as int,
      open: map['open'] as int,
      closed: map['closed'] as int,
    );
  }

  factory ActionItemsStats.fromJson(String source) =>
      ActionItemsStats.fromMap(json.decode(source) as Map<String, dynamic>);
}
