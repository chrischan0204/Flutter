// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class ObservationType extends Entity implements Equatable {
  final String observationType;
  final String severity;
  final String visibility;
  final bool isActive;
  ObservationType({
    required this.observationType,
    required this.severity,
    required this.visibility,
    required this.isActive,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Observation type': observationType,
      'Severity': severity,
      'Visibility': visibility,
      'Active': isActive,
    };
  }

  @override
  List<Object?> get props => [
        observationType,
        severity,
        visibility,
        isActive,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Observation type': observationType,
      'Severity': severity,
      'Visibility': visibility,
      'Active': isActive,
    };
  }
  
  @override
  Map<String, EntityInputType> inputTypesToMap() {
    // TODO: implement inputTypesToMap
    throw UnimplementedError();
  }
  
  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
