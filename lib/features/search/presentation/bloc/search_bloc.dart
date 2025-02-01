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
        emit(SearchLoading(state));
        Either response=await sl<SearchPropertyUseCase>().call(event.name);
        response.fold((l) => emit(SearchErrorState(state,failure: l)),(r) => emit(state.copyWith(property: r)));

    });
    on<HostSearchPropertyEvent>((event, emit)async{
      emit(SearchLoading(state));
      Either response=await sl<HostSearchPropertyUseCase>().call(event.name);
      response.fold((l) => emit(SearchErrorState(state,failure: l)),(r) => emit(state.copyWith(hostProperties: r)),);
    });
    on<LoadMoreGuestPropertiesEvent>(_loadMoreProperties);

  }
  void _loadMoreProperties(LoadMoreGuestPropertiesEvent event, Emitter<SearchState> emit) async {
    if (state is! SearchGuestLoadingMoreState && state.property.next != null) {
      final currentProperties = state.property;
      emit(SearchGuestLoadingMoreState(state));
      final response = await sl<SearchPropertyUseCase>().call(currentProperties.next);
      response.fold(
            (l) => emit(SearchErrorState(state,failure: l)),
            (r) {
              final updatedProperties = currentProperties.copyWith(
                results: [...currentProperties.results!, ...r.results!],
                next: r.next,
                count: r.count,
                previous: r.previous,
              );
          emit(state.copyWith(property: updatedProperties));
        },
      );
    }
  }

}
