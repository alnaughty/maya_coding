import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maya_coding_test/data/models/transaction.dart';
import 'package:maya_coding_test/data/models/user/user_details.dart';

class UserProviders {
  static final userDetailsProvider = StateProvider<UserDetails?>((ref) => null);
  static final userBalanceProvider = StateProvider<double>((ref) => 0.0);
  static final userTransactionProvider =
      StateProvider<List<TransactionModel>?>((ref) => null);
}
