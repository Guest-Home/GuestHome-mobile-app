import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/get_popular_property_usecase.dart';

import '../../../../../../../service_locator.dart';

part 'popular_property_event.dart';
part 'popular_property_state.dart';

class PopularPropertyBloc extends Bloc<PopularPropertyEvent, PopularPropertyState> {
  PopularPropertyBloc() : super(PopularPropertyInitial()) {
    on<GetPopularPropertyEvent>((event, emit)async{
       emit(PopularPropertyLoadingState());
       Either response=await sl<GetPopularPropertyUseCase>().call();
       response.fold((l) => emit(PopularPropertyErrorState(failure: l)), (r) => emit(PopularPropertyLoadedState(properties: r)),);

    });
  }
}
