import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_event/ticket_history_event.dart';
import '../auth_state/ticket_history_state.dart';
import '../repo/fetch_station.dart';
import '../repo/ticket_history_repo.dart';

class TicketHistoryBloc extends Bloc<TicketHistoryEvent, TicketHistoryState> {
  final TicketHistoryRepository ticketHistoryRepository;

  TicketHistoryBloc(this.ticketHistoryRepository) : super(TicketHistoryInitial()) {
    on<FetchTicketHistory>((event, emit) async {
      emit(TicketHistoryLoading());
      try {
        final tickets = await ticketHistoryRepository.getUserHistory(); // ✅ التعديل هنا
        emit(TicketHistoryLoaded(tickets));
      } catch (e) {
        print('❌ Error in getUserHistory: $e');
        emit(TicketHistoryError(e.toString()));
      }
    });
  }
}