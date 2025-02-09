class TransactionModel {
  final String id;
  final int receiverID;
  final int senderID;
  final String sentTo;
  final String sendBy;
  final double amount;
  final DateTime createdAt;
  const TransactionModel({
    required this.amount,
    required this.createdAt,
    required this.id,
    required this.receiverID,
    required this.sendBy,
    required this.senderID,
    required this.sentTo,
  });

  factory TransactionModel.fromFirebase(Map<String, dynamic> data, String id) {
    return TransactionModel(
      amount: data['amount'] as double,
      createdAt: DateTime.parse(data['created_at'] as String),
      id: id,
      receiverID: data['receiver_id'] as int,
      sendBy: data['sent_by'] as String,
      senderID: data['sender_id'] as int,
      sentTo: data['sent_to'] as String,
    );
  }
}
