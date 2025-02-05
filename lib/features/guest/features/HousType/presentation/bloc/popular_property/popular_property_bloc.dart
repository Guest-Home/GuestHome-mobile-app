import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/get_popular_property_usecase.dart';

import '../../../../../../../service_locator.dart';

part 'popular_property_event.dart';
part 'popular_property_state.dart';

class PopularPropertyBloc extends Bloc<PopularPropertyEvent, PopularPropertyState> {
  PopularPropertyBloc() : super(PopularPropertyInitial()) {
    on<GetPopularPropertyEvent>((event, emit)async{
       emit(PopularPropertyLoadingState(state));
       Either response=await sl<GetPopularPropertyUseCase>().call("");
       response.fold((l) => emit(PopularPropertyErrorState(state,failure: l)), (r) => emit(state.copyWith(
         properties: r
       )),);
    });
    on<LoadMorePopularPropertiesEvent>(_loadMoreProperties);
  }
  void _loadMoreProperties(LoadMorePopularPropertiesEvent event, Emitter<PopularPropertyState> emit) async {
    if (state is! PopularPropertyLoadingMoreState && state.properties.next != null) {
      final currentProperties = state.properties;
      emit(PopularPropertyLoadingMoreState(state));
      final response = await sl<GetPopularPropertyUseCase>().call(currentProperties.next);
      response.fold(
            (l) => emit(PopularPropertyErrorState(state, failure: l)),
            (r) {
              final updatedProperties = currentProperties.copyWith(
                results: [...currentProperties.results!, ...r.results!],
                next: r.next, // Will be null when no more pages
                count: r.count,
                previous: r.previous,
              );
          emit(state.copyWith(properties: updatedProperties));
        },
      );
    }
  }
}
