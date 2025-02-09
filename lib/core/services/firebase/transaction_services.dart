import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maya_coding_test/data/models/transaction.dart';
import 'package:maya_coding_test/data/models/user/user_modeld.dart';

class TransactionServices {
  final collection = FirebaseFirestore.instance.collection('user-transactions');

  Future<void> addTransaction({
    required UserModel sender,
    required UserModel receiver,
    required double amount,
  }) async {
    final Map<String, dynamic> data = {
      "users": [sender.id, receiver.id],
      "sender_id": sender.id,
      "sent_by": sender.name,
      "sent_to": receiver.name,
      "receiver_id": receiver.id,
      "amount": amount,
      "created_at": DateTime.now().toLocal().toIso8601String(),
    };

    collection.add(data);
  }

  Stream<List<TransactionModel>> streamListener(int userId) {
    return collection
        .where("users", arrayContains: userId) // Filter by user involvement
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => TransactionModel.fromFirebase(doc.data(), doc.id),
            )
            .toList());
  }
}
