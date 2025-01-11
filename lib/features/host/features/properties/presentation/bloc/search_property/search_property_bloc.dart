import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/search_property_usecase.dart';

import '../../../../../../../service_locator.dart';

part 'search_property_event.dart';
part 'search_property_state.dart';

class SearchPropertyBloc extends Bloc<SearchPropertyEvent, SearchPropertyState> {
  SearchPropertyBloc() : super(SearchPropertyInitial()) {
    on<SearchEvent>((event, emit)async{
      emit(SearchPropertyLoading());
      Either response=await sl<SearchPropertyUseCase>().call(event.name);
      response.fold((l) => emit(SearchPropertyError(failure: l)), (r) => emit(SearchPropertyLoaded(properties: r)),);
    });
    on<ResetEvent>((event, emit) => emit(SearchPropertyInitial()));
  }
}
