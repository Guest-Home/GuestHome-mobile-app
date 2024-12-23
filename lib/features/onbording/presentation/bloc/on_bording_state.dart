part of 'on_bording_bloc.dart';

class OnBordingState extends Equatable {
  OnBordingState({this.index = 0, this.progress = 0.2});

  int index;
  double progress;
  List<String> language = ["English", "አማርኛ", "Afan Oromo"];

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
  GetStartedState();
}
