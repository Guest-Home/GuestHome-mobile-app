import 'package:minapp/features/auth/domain/entities/customer_profile_entity.dart';

class CustomerProfileModel extends CustomerProfileEntity {
  const CustomerProfileModel(
      {required super.id,
      // required super.userAccount,
      required super.profilePicture,
      required super.phoneNumber,
      required super.typeOfCustomer,
      required super.rating,
      required super.chatId,
      required super.isApproved,
      required super.points,
      required super.agent,
      required super.language});

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) =>
      CustomerProfileModel(
        id: json["id"],
        // userAccount: json["userAccount"],
        profilePicture: json["profilePicture"],
        phoneNumber: json["phoneNumber"],
        typeOfCustomer: json["typeOfCustomer"],
        rating: json["rating"],
        chatId: json["chatId"],
        isApproved: json["is_approved"],
        points: json["points"],
        agent: json["agent"],
        language: json["language"],
      );
}
