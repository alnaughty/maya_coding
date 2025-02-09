import 'package:flutter_test/flutter_test.dart';
import 'package:maya_coding_test/core/services/auth_services.dart';

void main() {
  final AuthServices _authAPI = AuthServices();

  test("AUTH VALID USER TEST", () async {
    var result = await _authAPI.login(
        email: "Sincere@april.biz", password: "password", isTest: true);
    var val = result.isRight();
    expect(val, true);
  });
  test("AUTH INVALID USER TEST", () async {
    var result = await _authAPI.login(
        email: "sad@fsdfsdf.dsssadasdasdadadad",
        password: "password",
        isTest: true);
    var val = result.isLeft();
    expect(val, false);
  });
}
