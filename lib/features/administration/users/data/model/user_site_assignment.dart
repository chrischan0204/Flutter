// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserSiteAssignment extends Equatable {
  final String siteId;
  final String userId;
  const UserSiteAssignment({
    required this.siteId,
    required this.userId,
  });
  @override
  List<Object?> get props => [
        siteId,
        userId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());
}
