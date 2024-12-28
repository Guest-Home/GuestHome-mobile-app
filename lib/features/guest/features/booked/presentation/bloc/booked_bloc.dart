import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booked_event.dart';
part 'booked_state.dart';

class BookedBloc extends Bloc<BookedEvent, BookedState> {
  BookedBloc() : super(BookedInitial()) {
    on<BookedEvent>((event, emit) {});
  }
}
