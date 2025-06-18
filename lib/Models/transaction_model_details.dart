import 'package:brt_proj/Models/ticket_model.dart';

class TransactionDetailModel {
  final String number;
  final double price;
  final int count;
  final TicketCategory ticketCategory;

  TransactionDetailModel({
    required this.number,
    required this.price,
    required this.count,
    required this.ticketCategory,
  });

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
      number: json['number'] ?? '',
      price: (json['price'] as num).toDouble(),
      count: json['count'] ?? 0,
      ticketCategory: TicketCategory.fromJson(json['ticketCategory']),
    );
  }
}