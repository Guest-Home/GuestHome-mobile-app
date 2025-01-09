import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../service_locator.dart';
import '../../domain/entities/total_no_property_entity.dart';
import '../../domain/usecases/get_total_property_usecase.dart';

part 'total_property_event.dart';
part 'total_property_state.dart';

class TotalPropertyBloc extends Bloc<TotalPropertyEvent, TotalPropertyState> {
  TotalPropertyBloc() : super(TotalPropertyInitial()) {
    on<GetTotalPropertyEvent>((event, emit) async{
      emit(TotalPropertyLoadingState());
      Either response=await sl<GetTotalPropertyUsecase>().call();
      response.fold((l) => emit(TotalPropertyErrorState(failure: l)), (r) => emit(state.copyWith(totalProperty: r)),);
    },);
  }
}
