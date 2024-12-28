import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'guesthome_event.dart';
part 'guesthome_state.dart';

class GuesthomeBloc extends Bloc<GuesthomeEvent, GuesthomeState> {
  GuesthomeBloc() : super(GuesthomeInitial()) {
    on<GuesthomeEvent>((event, emit) {});
  }
}
