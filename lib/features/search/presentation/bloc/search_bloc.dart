import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/search/domain/usecases/host_search_property_usecase.dart';
import 'package:minapp/features/search/domain/usecases/search_property_usecase.dart';

import '../../../../service_locator.dart';
import '../../../host/features/properties/domain/entities/property_entity.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchPropertyEvent>((event, emit)async{
        emit(SearchLoading());
        Either response=await sl<SearchPropertyUseCase>().call(event.name);
        response.fold((l) => emit(SearchErrorState(failure: l)),(r) => emit(SearchGuestLodeState(property: r)));

    });
    on<HostSearchPropertyEvent>((event, emit)async{
      emit(SearchLoading());
      Either response=await sl<HostSearchPropertyUseCase>().call(event.name);
      response.fold((l) => emit(SearchErrorState(failure: l)),(r) => emit(SearchHostLodeState(properties: r)),);
    });
  }
}
