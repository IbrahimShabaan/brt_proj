import '../../Models/ticket_history_model.dart';

abstract class TicketHistoryState {}

class TicketHistoryInitial extends TicketHistoryState {}

class TicketHistoryLoading extends TicketHistoryState {}

class TicketHistoryLoaded extends TicketHistoryState {
  final List<TicketHistoryModel> tickets;

  TicketHistoryLoaded(this.tickets);
}

class TicketHistoryError extends TicketHistoryState {
  final String message;

  TicketHistoryError(this.message);
}