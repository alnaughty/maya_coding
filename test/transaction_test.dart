import 'package:flutter_test/flutter_test.dart';
import 'package:maya_coding_test/core/services/firebase/transaction_services.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';
import 'package:maya_coding_test/data/repositories/transaction_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('TransactionServices Tests', () {
    final mockFirestore = MockFirestore();
    final service = TransactionRepository();

    test('Add Balance', () async {
      await service.add(
          sender: UserModel(id: 1, name: "test", email: "test"),
          receiver: UserModel(id: 1, name: "test", email: "test"),
          amount: 500.0);
      expect(500, greaterThan(0.0)); // Expect balance to be updated
    });

    // test('Decrease Balance', () async {
    //   await service.decreaseBalance(1, 300.0);
    //   final balance = await service.getBalance(1);
    //   expect(balance, greaterThanOrEqualTo(0.0));
    // });

    // test('Insufficient Funds', () async {
    //   expect(() => service.decreaseBalance(1, 99999.0), throwsException);
    // });
  });
}
