// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/data/model/entity.dart';

class PriorityLevel extends Entity implements Equatable {
  final String priorityLevel;
  final Color colorAssociated;
  final String priorityType;
  final bool isActive;
  PriorityLevel({
    required this.priorityLevel,
    required this.colorAssociated,
    required this.priorityType,
    required this.isActive,
  });
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Priority Level': priorityLevel,
      'Color associated': colorAssociated,
      'Priority Type': priorityType,
      'Active': isActive,
    };
  }

  @override
  List<Object?> get props => [
        priorityLevel,
        colorAssociated,
        priorityType,
        isActive,
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Priority Level': priorityLevel,
      'Color associated': colorAssociated,
      'Priority Type': priorityType,
      'Active': isActive,
    };
  }

  PriorityLevel copyWith({
    String? priorityLevel,
    Color? colorAssociated,
    String? priorityType,
    bool? isActive,
  }) {
    return PriorityLevel(
      priorityLevel: priorityLevel ?? this.priorityLevel,
      colorAssociated: colorAssociated ?? this.colorAssociated,
      priorityType: priorityType ?? this.priorityType,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, EntityInputType> inputTypesToMap() {
    return <String, EntityInputType>{
      'Region': EntityInputType.singleSelect,
      'Timezone': EntityInputType.multiSelect,
    };
  }
  
  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
