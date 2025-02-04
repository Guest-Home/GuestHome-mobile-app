part of 'deposit_transaction_bloc.dart';


abstract class DepositTransactionEvent {}

class GetDepositTransactionEvent extends DepositTransactionEvent{}
class LoadMoreDepositTransactionEvent extends DepositTransactionEvent{}
