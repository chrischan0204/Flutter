// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserSiteNotification extends Equatable {
  final String id;
  final String siteId;
  final String siteName;
  final String userId;
  final bool goodCatch;
  final bool nearMiss;
  final bool safe;
  final bool unsafe;
  const UserSiteNotification({
    required this.id,
    required this.siteId,
    required this.siteName,
    required this.userId,
    required this.goodCatch,
    required this.nearMiss,
    required this.safe,
    required this.unsafe,
  });

  @override
  List<Object?> get props => [
        id,
        siteId,
        siteName,
        userId,
        goodCatch,
        nearMiss,
        safe,
        unsafe,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'siteId': siteId,
      'siteName': siteName,
      'userId': userId,
      'goodCatch': goodCatch,
      'nearMiss': nearMiss,
      'safe': safe,
      'unsafe': unsafe,
    };
  }

  factory UserSiteNotification.fromMap(Map<String, dynamic> map) {
    return UserSiteNotification(
      id: map['id'] as String,
      siteId: map['siteId'] as String,
      siteName: map['siteName'] as String,
      userId: map['userId'] as String,
      goodCatch: map['goodCatch'] as bool,
      nearMiss: map['nearMiss'] as bool,
      safe: map['safe'] as bool,
      unsafe: map['unsafe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSiteNotification.fromJson(String source) =>
      UserSiteNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
