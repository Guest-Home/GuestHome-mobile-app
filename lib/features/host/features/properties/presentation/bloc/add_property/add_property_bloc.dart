import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyState()) {
    on<NextStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step + 1));
    });
    on<BackStepEvent>((event, emit) {
      print(state.step);
      emit(state.copyWith(step: state.step == 0 ? 0 : state.step - 1));
      print(state.step);
    });
  }
}
