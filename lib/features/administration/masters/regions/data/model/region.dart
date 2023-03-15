// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class Region extends Entity implements Equatable {
  final String regionName;
  final List<String> timezonesAssociated;
  final bool active;
  Region({
    required this.regionName,
    required this.timezonesAssociated,
    required this.active,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Region Name': regionName,
      'Time Zones Associated': timezonesAssociated,
      'Active': active,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Region Name': regionName,
      'Time Zones Associated': timezonesAssociated,
      'Active': active,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        regionName,
        timezonesAssociated,
        active,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  Region copyWith({
    String? regionName,
    List<String>? timezonesAssociated,
    bool? active,
  }) {
    return Region(
      regionName: regionName ?? this.regionName,
      timezonesAssociated: timezonesAssociated ?? this.timezonesAssociated,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'regionName': regionName,
      'timezonesAssociated': timezonesAssociated,
      'active': active,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      regionName: map['regionName'] as String,
      timezonesAssociated:
          List<String>.from((map['timezonesAssociated'] as List<String>)),
      active: map['active'] as bool,
    );
  }
}
