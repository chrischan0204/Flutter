import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final String roleName;
  final String token;
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'roleName': roleName,
      'token': token,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      roleName: map['roleName'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        roleName,
        token,
      ];
}
