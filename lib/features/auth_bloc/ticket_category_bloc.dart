import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_event/ticket_category_event.dart';
import '../auth_state/auth_state.dart';
import '../auth_state/ticket_category_state.dart';
import '../repo/ticket_category_repo.dart';

class TicketCategoryBloc extends Bloc<TicketCategoryEvent, TicketCategoryState> {
  final TicketCategoryRepository repository;

  TicketCategoryBloc({required this.repository}) : super(TicketCategoryInitial()) {
    on<FetchTicketCategory>((event, emit) async {
      emit(TicketCategoryLoading());
      try {
        final ticketCategory = await repository.fetchTicketCategory(
          fromStationId: event.fromStationId,
          toStationId: event.toStationId,
        );
        emit(TicketCategoryLoaded(ticketCategory));
      } catch (e) {
        emit(TicketCategoryError(e.toString()));
      }
    });
  }
}