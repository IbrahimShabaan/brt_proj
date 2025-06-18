import '../../Models/create_transaction_model.dart';
import '../../Models/transaction_model.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {

  final TransactionModel transaction;
  TransactionSuccess(this.transaction);
}

class TransactionFailure extends TransactionState {
  final String error;
  TransactionFailure(this.error);
}