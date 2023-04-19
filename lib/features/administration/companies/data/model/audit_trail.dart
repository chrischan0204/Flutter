import '/data/model/model.dart';

class AuditTrail extends Entity {
  String? action;
  String? oldValue;
  String? newValue;
  String? description;
  AuditTrail({
    this.action,
    this.oldValue,
    this.newValue,
    this.description,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
  });

  @override
  List<Object?> get props => [
        action,
        oldValue,
        newValue,
        description,
      ];

  factory AuditTrail.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return AuditTrail(
      action: map['action'],
      oldValue: map['oldValue'],
      newValue: map['newValue'],
      description: map['description'],
      lastModifiedByUserName: entity.lastModifiedByUserName,
      lastModifiedOn: entity.lastModifiedOn,
    );
  }

  Map<String, dynamic> toTableDetailMap() {
    return {
      'Change': action,
      'From': oldValue,
      'To': newValue,
      'Changed By': lastModifiedByUserName,
      'Changed On': lastModifiedOn,
    };
  }

  AuditTrail copyWith({
    String? action,
    String? oldValue,
    String? newValue,
    String? description,
    String? lastModifiedByUserName,
    String? lastModifiedOn,
  }) {
    return AuditTrail(
      action: action ?? this.action,
      oldValue: oldValue ?? this.oldValue,
      newValue: newValue ?? this.newValue,
      description: description ?? this.description,
      lastModifiedByUserName:
          lastModifiedByUserName ?? this.lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
    );
  }
}
