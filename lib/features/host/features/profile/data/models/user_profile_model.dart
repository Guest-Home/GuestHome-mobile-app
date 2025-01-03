
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
    const UserProfileModel( {
      required super.id,
       required super.userAccount,
      required super.profilePicture,
      required super.phoneNumber,
      required super.typeOfCustomer,
      required super.rating,
      required super.chatId,
      required super.isApproved,
      required super.points,
      required super.agent,
      required super.language,
      required super.gender});


  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    id: json["id"],
    userAccount: UserAccountModel.fromMap(json["userAccount"]),
    phoneNumber: json["phoneNumber"],
    profilePicture: json["profilePicture"],
    typeOfCustomer: json["typeOfCustomer"],
    rating: json["rating"],
    chatId: json["chatId"],
    isApproved: json["is_approved"],
    points: json["points"],
    gender: json["gender"],
    agent: json["agent"],
    language: json["language"],
  );

}

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required id,
    required username,
    required email,
    required firstName,
    required lastName,
    required isStaff,
  }) : super(id: id, username: username, email: email, firstName: firstName, lastName: lastName, isStaff: isStaff);

  factory UserAccountModel.fromMap(Map<String, dynamic> json) => UserAccountModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isStaff: json["is_staff"],
  );

}
