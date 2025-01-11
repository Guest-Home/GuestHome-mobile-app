import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/get_house_bytype_usecase.dart';

import '../../../../../../service_locator.dart';

part 'houstype_event.dart';
part 'houstype_state.dart';

class HoustypeBloc extends Bloc<HoustypeEvent, HoustypeState> {
  HoustypeBloc() : super(HoustypeInitial()) {
    on<GetPropertyByHouseTypeEvent>((event, emit) async {
      Either response = await sl<GetHouseBytypeUsecase>().call(event.name);
    });
  }
}
