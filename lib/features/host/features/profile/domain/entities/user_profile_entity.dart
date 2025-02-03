import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final int? id;
  final UserAccountEntity? userAccount;
  final String? phoneNumber;
  final String? profilePicture;
  final String? typeOfCustomer;
  final int? rating;
  final dynamic chatId;
  final bool? isApproved;
  final double? points;
  final String? gender;
  final dynamic agent;
  final String? language;

  const UserProfileEntity({
     this.id,
     this.userAccount,
     this.phoneNumber,
     this.profilePicture,
     this.typeOfCustomer,
     this.rating,
     this.chatId,
     this.isApproved,
     this.points,
     this.gender,
     this.agent,
     this.language,
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
