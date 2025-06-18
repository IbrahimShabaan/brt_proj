class CreateTransactionModel {
  final int shiftId;
  final List<TransactionDetail> transactionDetails;

  CreateTransactionModel({
    required this.shiftId,
    required this.transactionDetails,
  });

  Map<String, dynamic> toJson() => {
    "shiftId": shiftId,
    "transactionDetails": transactionDetails.map((e) => e.toJson()).toList(),
  };
}

class TransactionDetail {
  final int count;
  final int ticketCategoryId;
  final int profileId;
  final String tripDate;

  TransactionDetail({
    required this.count,
    required this.ticketCategoryId,
    required this.profileId,
    required this.tripDate,
  });

  Map<String, dynamic> toJson() => {
    "count": count,
    "ticketCategoryId": ticketCategoryId,
    "profileId": profileId,
    "tripDate": tripDate,
  };
}