import 'package:shared_preferences/shared_preferences.dart';

class DataCacher {
  DataCacher._pr();
  static final DataCacher _instance = DataCacher._pr();
  static DataCacher get instance => _instance;

  late final SharedPreferences _prefs;
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUID(int id) async => await _prefs.setInt('user_id', id);
  Future<void> removeID() async => _prefs.remove('user_id');
  int? get userUD => _prefs.getInt('user_id');
}
