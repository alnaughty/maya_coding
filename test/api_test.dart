import 'package:flutter_test/flutter_test.dart';
import 'package:maya_coding_test/core/services/auth_services.dart';

void main() {
  final AuthServices _authAPI = AuthServices();

  test("AUTH VALID USER TEST", () async {
    var result =
        await _authAPI.login(email: "Sincere@april.biz", password: "password");
    var val = result.isRight();
    expect(val, true);
  });
  test("AUTH INVALID USER TEST", () async {
    var result = await _authAPI.login(
        email: "asdasdadssd@fsdfsdf.ffbiz", password: "password");
    var val = result.isRight();
    expect(val, false);
  });
}
