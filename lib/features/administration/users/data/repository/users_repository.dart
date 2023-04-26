import 'dart:convert';

import 'package:http/http.dart';

import '/constants/uri.dart';
import '/data/model/model.dart';

class UsersRepository {
  static String url = '/api/Users';
  static List<User> users = List.generate(
      30,
      (index) => User(
            id: index.toString(),
            firstName: 'firstName$index',
            lastName: 'lastName$index',
            email: 'email$index',
            mobileNumber: 'mobileNumber$index',
            inviteSent: true,
            roleName: 'roleName$index',
            title: 'title$index',
            defaultSiteName: 'defaultSiteName$index',
            siteAccess: 'siteAccess$index',
            timeZoneName: 'timeZoneName$index',
            timeZoneId: 'timeZoneId$index',
          )).toList();

  // get users list
  Future<List<User>> getUsers() async {
    Response response = await get(Uri.https(ApiUri.host, url));

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
    Response response = await get(Uri.https(ApiUri.host, '$url/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }

    throw Exception();
  }

  // add user
  Future<EntityResponse> addUser(User user) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: user.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit user
  Future<EntityResponse> editUser(User user) async {
    Response response = await put(
      Uri.https(ApiUri.host, url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'plain/text',
      },
      body: user.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteUser(String userId) async {
    Response response = await delete(Uri.https(ApiUri.host, '$url/$userId'));

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }
}
