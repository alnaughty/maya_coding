import 'package:maya_coding_test/core/services/user_services.dart';
import 'package:maya_coding_test/data/models/user/user_details.dart';

class UserRepository {
  final UserServices _api = UserServices();

  Future<UserDetails> getDetails(int id) async {
    try {
      final userData = await _api.fetchUserById(id);
      return userData.fold((error) {
        throw error;
      }, (data) {
        return data;
      });
      // return userData != null ? UserModel.fromJson(userData) : null;
    } catch (e) {
      rethrow; // Pass error up to the UI layer
    }
  }
}
