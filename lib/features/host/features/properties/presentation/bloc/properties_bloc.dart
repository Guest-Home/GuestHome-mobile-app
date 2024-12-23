import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  PropertiesBloc() : super(PropertiesInitial()) {
    on<PropertiesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
