import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'houstype_event.dart';
part 'houstype_state.dart';

class HoustypeBloc extends Bloc<HoustypeEvent, HoustypeState> {
  HoustypeBloc() : super(HoustypeInitial()) {
    on<HoustypeEvent>((event, emit) {});
  }
}
