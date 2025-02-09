import 'package:maya_coding_test/core/services/firebase/transaction_services.dart';
import 'package:maya_coding_test/data/models/transaction.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';

class TransactionRepository {
  final TransactionServices _service = TransactionServices();

  Future<void> add({
    required UserModel sender,
    required UserModel receiver,
    required double amount,
  }) async {
    await _service.addTransaction(
      sender: sender,
      receiver: receiver,
      amount: amount,
    );
  }

  Stream<List<TransactionModel>> get(int id) {
    return _service.streamListener(id);
  }
}
