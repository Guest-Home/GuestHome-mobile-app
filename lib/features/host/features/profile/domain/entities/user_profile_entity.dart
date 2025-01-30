import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final int id;
  final UserAccountEntity userAccount;
  final String phoneNumber;
  final String? profilePicture;
  final String typeOfCustomer;
  final int rating;
  final dynamic chatId;
  final bool isApproved;
  final double? points;
  final String gender;
  final dynamic agent;
  final String language;

  const UserProfileEntity({
    required this.id,
    required this.userAccount,
    required this.phoneNumber,
    required this.profilePicture,
    required this.typeOfCustomer,
    required this.rating,
    required this.chatId,
    required this.isApproved,
    required this.points,
    required this.gender,
    required this.agent,
    required this.language,
  });

  @override
  List<Object?> get props => [
        id,
        userAccount,
        profilePicture,
        phoneNumber,
        typeOfCustomer,
        rating,
        chatId,
        isApproved,
        points,
        agent,
        language
      ];
}

class UserAccountEntity extends Equatable {
  final int id;
  final String username;
  final String? email;
  final String firstName;
  final String? lastName;
  final bool isStaff;

  const UserAccountEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isStaff,
  });

  @override
  List<Object?> get props =>
      [id, username, email, firstName, lastName, isStaff];
}
