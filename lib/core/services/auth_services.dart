import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:maya_coding_test/config/constants.dart';
import 'package:maya_coding_test/core/extensions/string.dart';
import 'package:maya_coding_test/core/services/data_cacher.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';
// import 'package:maya_coding_test/data/models/user_model.dart';

class AuthServices {
  final DataCacher _cacher = DataCacher.instance;
  Future<Either<Exception, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final response = await http.get(
        "${AppConstants.apiBaseUrl}/users".toUri(),
        headers: AppConstants.headers,
        // body: jsonEncode({
        //   "email": email,
        //   "password": password,
        // }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        final List users = json.decode(response.body);
        final user = users
            .where((e) =>
                e['email'].toString().toLowerCase() == email.toLowerCase())
            .firstOrNull;
        print(user);
        if (user != null) {
          final UserModel u = UserModel.fromJson(user);
          await _cacher.setUID(u.id);
          return Right(u);
        }
        return Left(Exception('User not found'));
        // Simulate token since JSONPlaceholder doesn’t provide one
        // data['token'] = 'fake-jwt-token-123';
        // data['name'] = 'Test User';
        // print(data);
        // return Right(UserModel.fromJson(data));
      } else {
        print("ERROR ");
        throw HttpException("Invalid response: ${response.statusCode}");
      }
    } on http.ClientException {
      print("ERROR");
      return Left(http.ClientException("Failed to connect to server"));
    } on TimeoutException {
      print("ERROR TIMEOUT");
      return Left(
          TimeoutException("Connection timeout, request is taking a while"));
    } on SocketException {
      print("ERROR SOCKET");
      return Left(SocketException("No internet connection"));
    } catch (e) {
      print("ERROR $e");
      return Left(
        Exception(e.toString()),
      );
    }
  }
}
