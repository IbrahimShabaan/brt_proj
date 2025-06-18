import '../../Models/ticket_model.dart';

abstract class TicketCategoryState {}

class TicketCategoryInitial extends TicketCategoryState {}

class TicketCategoryLoading extends TicketCategoryState {}

class TicketCategoryLoaded extends TicketCategoryState {
  final TicketCategory ticketCategory;

  TicketCategoryLoaded(this.ticketCategory);
}

class TicketCategoryError extends TicketCategoryState {
  final String message;

  TicketCategoryError(this.message);
}