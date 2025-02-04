part of 'deposit_transaction_bloc.dart';


class DepositTransactionState extends Equatable {
  const DepositTransactionState({this.depositTransactionEntity=const DepositTransactionEntity()});

  final DepositTransactionEntity depositTransactionEntity;

  DepositTransactionState copyWith({
    DepositTransactionEntity? depositTransactionEntity
  }){
    return DepositTransactionState(
      depositTransactionEntity: depositTransactionEntity??this.depositTransactionEntity
    );
  }

  @override
  List<Object?> get props =>[depositTransactionEntity];
}

final class DepositTransactionInitial extends DepositTransactionState {}
class DepositTransactionLoading extends DepositTransactionState {
  DepositTransactionLoading(DepositTransactionState currentState):super(
      depositTransactionEntity: currentState.depositTransactionEntity
  );
}
class DepositTransactionLoadingMoreState extends DepositTransactionState {
  DepositTransactionLoadingMoreState(DepositTransactionState currentState):super(
      depositTransactionEntity: currentState.depositTransactionEntity
  );
}
class DepositTransactionError extends DepositTransactionState {
  final Failure failure;
  DepositTransactionError(DepositTransactionState currentState,{required this.failure}):super(
    depositTransactionEntity: currentState.depositTransactionEntity
  );
}
