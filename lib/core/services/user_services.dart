import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:maya_coding_test/config/constants.dart';
import 'package:maya_coding_test/core/extensions/string.dart';
import 'package:maya_coding_test/data/models/user/user_details.dart' as det;

class UserServices {
  Future<Either<Exception, det.UserDetails>> fetchUserById(int id) async {
    try {
      final response = await http.get(
        "${AppConstants.apiBaseUrl}/users/$id".toUri(),
        headers: AppConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("DATA $data");
        return Right(det.UserDetails.fromMap(data));
      } else {
        print(response.body);
        return Left(Exception('Failed to fetch user'));
      }
    } catch (e, s) {
      print("STACKTRACE: $s");
      print('Error: $e');
      return Left(
        Exception(e),
      );
    }
  }
}
