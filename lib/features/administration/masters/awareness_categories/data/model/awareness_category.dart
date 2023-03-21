// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class AwarenessCategory extends Entity implements Equatable {
  final String awarenessCategory;
  final bool active;
  AwarenessCategory({
    required this.awarenessCategory,
    required this.active,
    required super.id,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': awarenessCategory,
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        awarenessCategory,
        active,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': awarenessCategory,
      'Active': active,
    };
  }

  AwarenessCategory copyWith({
    String? id,
    String? awarenessCategory,
    bool? active,
  }) {
    return AwarenessCategory(
      id: id ?? this.id,
      awarenessCategory: awarenessCategory ?? this.awarenessCategory,
      active: active ?? this.active,
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
