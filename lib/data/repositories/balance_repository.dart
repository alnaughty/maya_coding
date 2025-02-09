import 'package:maya_coding_test/core/services/firebase/balance_services.dart';

class BalanceRepository {
  final BalanceServices _service = BalanceServices();
  Stream<double> get(int id) {
    return _service.streamBalance(id);
  }

  Future<void> increase(int id, double amount) async {
    await _service.addBalance(id, amount);
  }

  Future<void> decrease(int id, double amount) async =>
      await _service.decreaseBalance(id, amount);
}
