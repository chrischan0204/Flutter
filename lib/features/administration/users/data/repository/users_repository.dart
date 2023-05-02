import 'dart:convert';

import 'package:http/http.dart';
import 'package:safety_eta/common_libraries.dart';
import 'package:safety_eta/features/administration/users/data/model/user_site.dart';

import '/data/repository/repository.dart';
import '/constants/uri.dart';
import '/data/model/model.dart';

class UsersRepository extends BaseRepository {
  UsersRepository({required super.token}) : super(url: '/api/Users');

  // get users list
  Future<List<User>> getUsers() async {
    Response response = await get(
      Uri.https(ApiUri.host, url),
      headers: headers,
    );

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
    Response response = await get(
      Uri.https(ApiUri.host, '$url/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }

    throw Exception();
  }

  // add user
  Future<EntityResponse> addUser(User user) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: user.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit user
  Future<EntityResponse> editUser(User user) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: user.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteUser(String userId) async {
    Response response =
        await delete(Uri.https(ApiUri.host, '$url/$userId'), headers: headers);

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }

  Future<List<Role>> getUserRoles() async {
    Response response =
        await get(Uri.https(ApiUri.host, '$url/roles'), headers: headers);

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

    Response response = await get(
        Uri.https(ApiUri.host, '$url/$userId/sites', queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((siteMap) => UserSite.fromMap(siteMap))
          .toList();
    }
    return [];
  }

  Future<EntityResponse> assignSiteToUser(
      UserSiteAssignment userSiteAssignment) async {
    Response response = await post(
      Uri.https(ApiUri.host, '$url/assign/site'),
      headers: headers,
      body: userSiteAssignment.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
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
    Response response = await post(
        Uri.https(ApiUri.host, '$url/unassign/$userSiteAssignmentId/site'),
        headers: headers);

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
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
    Response response = await get(
        Uri.https(ApiUri.host, '$url/$userId/notifications'),
        headers: headers);

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
    Response response = await put(
      Uri.https(ApiUri.host, '$url/notifications'),
      headers: headers,
      body: userSiteNotification.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }
}
