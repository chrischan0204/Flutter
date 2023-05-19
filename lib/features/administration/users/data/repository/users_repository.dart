// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class UsersRepository extends BaseRepository {
  UsersRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Users');

  // get users list
  Future<List<User>> getUsers() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body))
          .map((userMap) => User.fromMap(userMap))
          .toList();
    }
    return [];
  }

  // get user by id
  Future<User> getUserById(
    String userId,
  ) async {
    Response response = await super.get('$url/$userId');

    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }

    throw Exception();
  }

  // add user
  Future<EntityResponse> addUser(User user) async {
    Response response = await super.post(url, body: user.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromJson(response.body);
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit user
  Future<EntityResponse> editUser(User user) async {
    Response response = await super.put(
      url,
      body: user.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteUser(String userId) async {
    Response response = await super.delete('$url/$userId');

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  Future<List<Role>> getUserRoles() async {
    Response response = await super.get('$url/roles');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((userRoleMap) => Role.fromMap(userRoleMap))
          .toList();
    }
    return [];
  }

  Future<List<UserSite>> getUserSitesByUserId(
    String userId, {
    String? name,
    bool? assigned,
  }) async {
    Map<String, String> queryParams = {};
    if (!Validation.isEmpty(name)) {
      queryParams.addEntries([MapEntry('name', name!)]);
    }

    if (assigned != null) {
      queryParams.addEntries([MapEntry('assigned', assigned.toString())]);
    }

    Response response = await super.get('$url/$userId/sites', queryParams);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((siteMap) => UserSite.fromMap(siteMap))
          .toList();
    }
    return [];
  }

  Future<EntityResponse> assignSiteToUser(
      UserSiteAssignment userSiteAssignment) async {
    Response response = await super.post(
      '$url/assign/site',
      body: userSiteAssignment.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> unassignSiteFromUser(
      String userSiteAssignmentId) async {
    Response response =
        await super.post('$url/unassign/$userSiteAssignmentId/site');

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<UserSiteNotification>> getSiteNotificationSettingsByUserId(
      String userId) async {
    Response response = await super.get('$url/$userId/notifications');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((notificationMap) =>
              UserSiteNotification.fromMap(notificationMap))
          .toList();
    }
    throw Exception();
  }

  Future<EntityResponse> updateUserSiteNotificationSetting(
      UserSiteNotification userSiteNotification) async {
    Response response = await super.put(
      '$url/notifications',
      body: userSiteNotification.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<UserInviteDetail>> getInviteDetails(String userId) async {
    Response response = await super.get('$url/$userId/invitedetails');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((inviteDetailMap) => UserInviteDetail.fromMap(inviteDetailMap))
          .toList();
    }

    throw Exception();
  }

  Future<EntityResponse> sendInvite(String userId) async {
    Response response = await super.post('$url/$userId/sendinvite');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw Exception();
  }

  Future<EntityResponse> register(String userId) async {
    Response response = await super.get('$url/$userId/register');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'message',
      );
    }
    throw Exception();
  }

  Future<EntityResponse> appDownload(String userId) async {
    Response response = await super.get('$url/$userId/appdownload');

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: 'message',
      );
    }
    throw Exception();
  }

  Future<List<User>> getFilteredUserList(
    String filterId,
    bool includeDeleted,
  ) async {
    Map<String, String> queryParams = {
      'includeDeleted': includeDeleted.toString(),
      'filterId': filterId,
    };
    Response response = await super.get('$url/list', queryParams);

    if (response.statusCode == 200) {
      final data = FilteredUserData.fromJson(response.body);
      final List<String> columns =
          List.from(data.headers.where((e) => !e.isHidden).map((e) => e.title));
      return data.data
          .map((e) => User(
                id: e.id,
                firstName: e.firstName,
                lastName: e.lastName,
                email: e.email,
                title: e.title,
                timeZoneName: e.timeZone,
                mobileNumber: e.mobileNumber,
                defaultSiteName: e.defaultSite,
                roleName: e.role,
                columns: columns,
              ))
          .toList();
    }
    throw Exception();
  }
}
