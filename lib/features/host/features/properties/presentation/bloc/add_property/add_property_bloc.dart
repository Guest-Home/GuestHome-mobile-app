import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyState()) {
    on<NextStepEvent>((event, emit) {
      if(state.step==6){
        emit(state.copyWith(step:0));
      }else{
        emit(state.copyWith(step: state.step + 1));
      }
    });
    on<BackStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step == 0 ? 0 : state.step - 1));
    });
  }
}
