// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class AwarenessCategory extends Entity implements Equatable {
  final String awarenessCategory;
  final bool isActive;
  AwarenessCategory({
    required this.awarenessCategory,
    required this.isActive,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': awarenessCategory,
      'Active': isActive,
    };
  }

  @override
  List<Object?> get props => [
        awarenessCategory,
        isActive,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': awarenessCategory,
      'Active': isActive,
    };
  }

  AwarenessCategory copyWith({
    String? awarenessCategory,
    bool? isActive,
  }) {
    return AwarenessCategory(
      awarenessCategory: awarenessCategory ?? this.awarenessCategory,
      isActive: isActive ?? this.isActive,
    );
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
