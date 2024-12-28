part of 'on_bording_bloc.dart';

class OnBordingState extends Equatable {
  const OnBordingState({this.index = 0, this.progress = 0.2});

  final int index;
  final double progress;

  OnBordingState copyWith({int? index, double? progress}) {
    return OnBordingState(
      index: index ?? this.index,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object> get props => [index, progress];
}

class GetStartedState extends OnBordingState {
  const GetStartedState();
}
