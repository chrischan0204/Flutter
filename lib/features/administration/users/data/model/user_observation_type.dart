import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserObservationType extends Equatable {
  final String observationTypeId;
  final bool sendNotification;
  const UserObservationType({
    required this.observationTypeId,
    required this.sendNotification,
  });

  @override
  List<Object?> get props => [
        observationTypeId,
        sendNotification,
      ];

  factory UserObservationType.fromMap(Map<String, dynamic> map) {
    return UserObservationType(
      observationTypeId: map['observationTypeId'] as String,
      sendNotification: map['sendNotification'] as bool,
    );
  }

  factory UserObservationType.fromJson(String source) =>
      UserObservationType.fromMap(json.decode(source) as Map<String, dynamic>);

  UserObservationType copyWith({
    String? observationTypeId,
    bool? sendNotification,
  }) {
    return UserObservationType(
      observationTypeId: observationTypeId ?? this.observationTypeId,
      sendNotification: sendNotification ?? this.sendNotification,
    );
  }
}
