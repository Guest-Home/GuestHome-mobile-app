part of 'on_bording_bloc.dart';

sealed class OnBordingEvent extends Equatable {
  const OnBordingEvent();
}


class onbordingChangeEvent extends OnBordingEvent{
  int index;
  onbordingChangeEvent({required this.index});



  @override
  List<Object?> get props =>[];
}