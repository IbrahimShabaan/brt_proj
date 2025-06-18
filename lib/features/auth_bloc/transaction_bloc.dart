import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/create_transaction_model.dart';
import '../auth_event/transaction_event.dart';
import '../auth_state/transaction_state.dart';
import '../repo/transaction_repo.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc({required this.repository,})
      : super(TransactionInitial()) {
    on<CreateTransactionPressed>(_onCreateTransactionPressed);
  }

  Future<void> _onCreateTransactionPressed(
      CreateTransactionPressed event,
      Emitter<TransactionState> emit,
      ) async {
    emit(TransactionLoading());

    try {
      final model = CreateTransactionModel(
        shiftId: 2,
        transactionDetails: [
          TransactionDetail(
            profileId: 1,
            ticketCategoryId: event.ticketCategoryId,
            count: event.count,
            tripDate: event.tripDate,
          ),
        ],
      );

     // print("📤 Sending Booking Request: ${model.toJson()}");

      //final response = await repository.createTransaction(model);

      //print("✅ Booking Response: $response");

      final transaction = await repository.createTransaction(model);

      emit(TransactionSuccess(transaction)); // ✅ مرر الموديل هنا
    } catch (e) {
      print("❌ Booking Error: $e");
      emit(TransactionFailure("حدث خطأ أثناء إنشاء الحجز: ${e.toString()}"));
    }
  }
}