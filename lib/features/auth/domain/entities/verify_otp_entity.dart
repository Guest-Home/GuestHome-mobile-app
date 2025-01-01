import 'package:equatable/equatable.dart';

class VerifyOtpEntity extends Equatable {
  final String refresh;
  final String access;
  const VerifyOtpEntity({
    required this.refresh,
    required this.access,
  });

  @override
  List<Object?> get props => [refresh, access];
}
