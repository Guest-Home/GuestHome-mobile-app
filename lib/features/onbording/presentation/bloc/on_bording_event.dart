part of 'on_bording_bloc.dart';

sealed class OnBordingEvent extends Equatable {
  const OnBordingEvent();
}

class OnBordingChangeEvent extends OnBordingEvent {
  const OnBordingChangeEvent();

  @override
  List<Object?> get props => [];
}

class OnBordingGetStartedEvent extends OnBordingEvent {
  const OnBordingGetStartedEvent();

  @override
  List<Object?> get props => [];
}
