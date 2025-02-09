import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceServices {
  final collection = FirebaseFirestore.instance.collection('user-balance');

  Stream<double> streamBalance(int id) {
    return collection.doc(id.toString()).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return double.parse(snapshot
            .data()!['amount']
            .toString()); // Ensure it returns a double
      }
      return 0.0; // Default value if balance does not exist
    });
  }

  /// Add balance to user's account
  Future<void> addBalance(int id, double amount) async {
    try {
      final docRef = collection.doc(id.toString());
      final snapshot = await docRef.get();
      if (snapshot.exists && snapshot.data() != null) {
        final double val = double.parse(snapshot.data()!["amount"].toString());
        print("CURRENT VALUE : $val");
        await docRef.set(
          {"amount": val + amount},
          SetOptions(merge: true),
        );
      }
      return; // Default amount if not found
    } catch (e) {
      print("Error fetching amount: $e");
      return; // Return default amount on error
    }
    // final docRef = collection.doc(id.toString());
    // final double current = await docRef.get(GetOptions())
    // final docRef = collection.doc(id.toString());
    // await FirebaseFirestore.instance.runTransaction((transaction) async {
    //   final snapshot = await transaction.get(docRef);
    //   if (snapshot.exists) {
    //     double currentBalance =
    //         double.parse(snapshot.data()!['amount'].toString());
    //     transaction.update(docRef, {'amount': currentBalance + amount});
    //   } else {
    //     transaction.set(docRef, {'amount': amount});
    //   }
    // });
  }

  /// Decrease balance from user's account
  Future<void> decreaseBalance(int id, double amount) async {
    final docRef = collection.doc(id.toString());
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (snapshot.exists) {
        double currentBalance =
            double.parse(snapshot.data()!['amount'].toString());
        if (currentBalance >= amount) {
          transaction.update(docRef, {'amount': currentBalance - amount});
        } else {
          throw Exception("Insufficient balance");
        }
      } else {
        throw Exception("User not found");
      }
    });
  }
}
