import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/get_house_bytype_usecase.dart';

import '../../../../../../service_locator.dart';
import '../../domain/entities/guest_property_entity.dart';

part 'houstype_event.dart';
part 'houstype_state.dart';

class HoustypeBloc extends Bloc<HoustypeEvent, HoustypeState> {
  HoustypeBloc() : super(HoustypeInitial()) {
    on<GetPropertyByHouseTypeEvent>((event, emit) async {
      emit(HouseTypeLoadingState(state));
      Either response = await sl<GetHouseBytypeUsecase>().call(event.name);
      response.fold((l) => emit(HouseTYpeErrorState(state,failure: l)), (r) => emit(state.copyWith(
        properties: r
      )),);
    });
    on<LoadMorePropertiesEvent>(_loadMoreProperties);

  }

  void _loadMoreProperties(LoadMorePropertiesEvent event, Emitter<HoustypeState> emit) async {
    if (state is! HouseTypeLoadingMoreState && state.properties.next!= null) {
      final currentProperties = state.properties;

        emit(HouseTypeLoadingMoreState(state));
        final response = await sl<GetHouseBytypeUsecase>().call(currentProperties.next!);
        response.fold(
              (l) => emit(HouseTYpeErrorState(state, failure: l)),
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
