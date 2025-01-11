import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_property_event.dart';
part 'search_property_state.dart';

class SearchPropertyBloc extends Bloc<SearchPropertyEvent, SearchPropertyState> {
  SearchPropertyBloc() : super(SearchPropertyInitial()) {
    on<SearchPropertyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
