abstract class TicketHistoryEvent {}

class FetchTicketHistory extends TicketHistoryEvent {
  final String? fromDate;
  final String? toDate;

  FetchTicketHistory({ this.fromDate,  this.toDate});
}