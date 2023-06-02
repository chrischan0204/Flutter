import '/common_libraries.dart';

class UserSiteNotification extends Equatable {
  final String headers;
  final SiteNotification data;
  const UserSiteNotification({
    required this.headers,
    required this.data,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  UserSiteNotification copyWith({
    String? headers,
    SiteNotification? data,
  }) {
    return UserSiteNotification(
      headers: headers ?? this.headers,
      data: data ?? this.data,
    );
  }

  factory UserSiteNotification.fromMap(Map<String, dynamic> map) {
    return UserSiteNotification(
      headers: map['headers'] as String,
      data: SiteNotification.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory UserSiteNotification.fromJson(String source) =>
      UserSiteNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
