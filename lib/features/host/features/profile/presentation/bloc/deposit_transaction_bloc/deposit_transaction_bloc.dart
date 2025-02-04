import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/profile/domain/entities/deposit_transaction_model.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_deposit_transaction_usecase.dart';

import '../../../../../../../service_locator.dart';

part 'deposit_transaction_event.dart';
part 'deposit_transaction_state.dart';

class DepositTransactionBloc extends Bloc<DepositTransactionEvent, DepositTransactionState> {
  DepositTransactionBloc() : super(DepositTransactionInitial()) {
    on<GetDepositTransactionEvent>((event, emit)async{
      emit(DepositTransactionLoading(state));
      Either response=await sl<GetDepositTransactionUsecase>().call("");
      response.fold((l) => emit(DepositTransactionError(state, failure: l)),
      (r) => emit(state.copyWith(depositTransactionEntity:r)),
      );
    });

    on<LoadMoreDepositTransactionEvent>(_loadMoreProperties);
  }
  void _loadMoreProperties(LoadMoreDepositTransactionEvent event, Emitter<DepositTransactionState> emit) async {
    if (state is! DepositTransactionLoadingMoreState && state.depositTransactionEntity.next!= null) {
      final currentTransaction = state.depositTransactionEntity;

      emit(DepositTransactionLoadingMoreState(state));
      final response = await sl<GetDepositTransactionUsecase>().call(currentTransaction.next!);
      response.fold(
            (l) => emit(DepositTransactionError(state, failure: l)),
            (r) {
          final updatedProperties = currentTransaction.copyWith(
            results: [...currentTransaction.results!, ...r.results!],
            next: r.next, // Will be null when no more pages
            count: r.count,
            previous: r.previous,
          );
          emit(state.copyWith(depositTransactionEntity: updatedProperties));
        },
      );
    }
  }
}
