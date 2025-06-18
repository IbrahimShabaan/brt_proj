import 'package:brt_proj/Models/transaction_model_details.dart';

class TransactionModel {
  final DateTime? createdAt;
  final List<TransactionDetailModel> transactionDetails;

  TransactionModel({
    required this.createdAt,
    required this.transactionDetails,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      transactionDetails: (json['transactionDetails'] as List)
          .map((e) => TransactionDetailModel.fromJson(e))
          .toList(),
    );
  }
}