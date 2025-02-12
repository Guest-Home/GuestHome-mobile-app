import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/filter_next_usecase.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/filter_property_usecase.dart';

import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../../core/utils/get_location.dart';
import '../../../../../../../service_locator.dart';
import '../../../domain/entities/guest_property_entity.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<AddPriceRange>((event, emit) {
      emit(state.copyWith(priceRange: event.prices));
    });
    on<AddFilterCityEvent>((event, emit) {
      emit(state.copyWith(city: event.city));
    });
    on<AddHouseTypeEvent>((event, emit) {
      emit(state.copyWith(category: event.houseType));
    });
    on<ResetEvent>((event, emit) {
      emit(FilterInitial());
    });
    on<AddIsNearSearchEvent>((event, emit)async{
      emit(state.copyWith(isNearSearch: event.isNear));
      if(event.isNear){
        final loc = await GetLocation().gatePosition();
        emit(state.copyWith(latitude: loc.latitude,longtiude: loc.longitude));
      }else{
        emit(state.copyWith(latitude:0.0,longtiude:0.0));
      }
    });

    on<FilterPropertyEvent>((event, emit)async{
      Map<String,dynamic> filterData={
        if(state.latitude!=0.0)
        "latitude":state.latitude,
        if(state.longtiude!=0.0)
        "longitude":state.longtiude,
        if(state.latitude!=0.0|| state.longtiude!=0.0)
        "range": 10,//in KM
        "minPrice": state.priceRange.start.ceil(),
        "maxPrice": state.priceRange.end.ceil(),
        "city":state.city,
        "category": state.category
      };
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        emit(FilterDataLoadingState(state));
        Either response= await sl<FilterPropertyUseCase>().call(filterData);
        response.fold((l) => emit(FilterErrorState(currentState: state, failure: l)),
                (r){
              emit(state.copyWith(properties: r));
              emit(FilterDataLoadedState(currentState: state));
            });
      }else{
        emit(NoInternetFilterState());
      }

    },);
    on<LoadMoreFilterPropertiesEvent>(_loadMoreProperties,);
  }

  void _loadMoreProperties(LoadMoreFilterPropertiesEvent event, Emitter<FilterState> emit) async {
    if (state is! FilterDataLoadingMoreState && state.properties.next != null) {
      final currentProperties = state.properties;
      Map<String,dynamic> filterData={
        "url":currentProperties.next,
          if(state.latitude!=0.0)
            "latitude":state.latitude,
          if(state.longtiude!=0.0)
            "longitude":state.longtiude,
          if(state.latitude!=0.0|| state.longtiude!=0.0)
            "range": 10,//in KM
          "minPrice": state.priceRange.start.ceil(),
          "maxPrice": state.priceRange.end.ceil(),
          "city":state.city,
          "category": state.category
      };
      emit(FilterDataLoadingMoreState(currentState: state));
      final response = await sl<FilterNextUseCase>().call(filterData);
      response.fold(
            (l) => emit(FilterErrorState(currentState: state, failure: l)),
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
