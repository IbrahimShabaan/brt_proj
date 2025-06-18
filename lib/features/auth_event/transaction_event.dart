abstract class TransactionEvent {}

class CreateTransactionPressed extends TransactionEvent {
  final int ticketCategoryId;
  final int count;
  final String tripDate;
  final int profileId;
  final int shiftId;

  CreateTransactionPressed({
    required this.ticketCategoryId,
    required this.count,
    required this.tripDate,
    required this.profileId,
    required this.shiftId,
  });
}