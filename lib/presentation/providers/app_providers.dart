import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maya_coding_test/core/services/app_services.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';
import 'package:maya_coding_test/presentation/providers/user_providers.dart';

class AppProviders {
  static final StateProvider<bool> showBalanceProvider =
      StateProvider<bool>((ref) => true);

  static final FutureProvider<List<UserModel>> userListFutureProvider =
      FutureProvider<List<UserModel>>((ref) async {
    final AppServices _api = AppServices();
    final res = await _api.getUsers();
    final me = ref.watch(UserProviders.userDetailsProvider);

    return res.fold(
        (error) => [], (data) => data.where((e) => e.id != me?.id).toList());
  });
}
