import 'package:equatable/equatable.dart';

class AgentPEntity extends Equatable {
  final int? id;
  final UserPEntity? user;
  final String? profilePicture;
  final bool? isActive;
  final String? sex;
  final String? phoneNumber;
  final String? city;

  const AgentPEntity({
    this.id,
    this.user,
    this.profilePicture,
    this.isActive,
    this.sex,
    this.phoneNumber,
    this.city,
  });

  @override
  List<Object?> get props =>
      [id, user, profilePicture, isActive, sex, phoneNumber, city];
}

class UserPEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;

  const UserPEntity({
    this.firstName,
    this.lastName,
    this.email,
  });

  @override
  List<Object?> get props => [firstName, lastName, email];
}
