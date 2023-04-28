// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
