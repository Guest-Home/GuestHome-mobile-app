import 'package:equatable/equatable.dart';

class VerifyOtpEntity extends Equatable {
  final String refresh;
  final String access;
  final bool hasProfile;
  const VerifyOtpEntity({
    required this.refresh,
    required this.access,
    required this.hasProfile
  });

  @override
  List<Object?> get props => [refresh, access,hasProfile];
}
