import 'package:safety_eta/common_libraries.dart';

class SiteNotification extends Equatable {
  final List<UserSiteSetting> sites;
  const SiteNotification({
    this.sites = const [],
  });

  @override
  List<Object?> get props => [sites];

  SiteNotification copyWith({
    List<UserSiteSetting>? sites,
  }) {
    return SiteNotification(
      sites: sites ?? this.sites,
    );
  }

  factory SiteNotification.fromMap(Map<String, dynamic> map) {
    return SiteNotification(
      sites: List.from(
        (map['sites']).map(
          (x) => UserSiteSetting.fromMap(x),
        ),
      ),
    );
  }

  factory SiteNotification.fromJson(String source) =>
      SiteNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
