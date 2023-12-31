
import 'package:safety_eta/common_libraries.dart';

class UserInviteDetail extends Equatable {
  final String action;
  final String createdOn;
  const UserInviteDetail({
    required this.action,
    required this.createdOn,
  });
  @override
  List<Object?> get props => [
        action,
        createdOn,
      ];

  factory UserInviteDetail.fromMap(Map<String, dynamic> map) {
    return UserInviteDetail(
      action: map['action'] as String,
      createdOn: map['createdOn'] == null
          ? ''
          : '${FormatDate(
              format: 'MM/dd/yyyy',
              dateString: map['createdOn'],
            ).formatDate} at ${FormatDate(
              format: '',
              dateString: map['createdOn'],
            ).formatTime}',
    );
  }

  factory UserInviteDetail.fromJson(String source) =>
      UserInviteDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
