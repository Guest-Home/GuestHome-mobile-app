import 'package:minapp/features/host/features/properties/domain/entities/agent_entity.dart';

class AgentPModel extends AgentPEntity {
  const AgentPModel({
    required super.id,
    required super.user,
    required super.profilePicture,
    required super.isActive,
    required super.sex,
    required super.phoneNumber,
    required super.city,
  });

  factory AgentPModel.fromMap(Map<String, dynamic> json) => AgentPModel(
        id: json["id"],
        user: UserPModel.fromMap(json["user"]),
        profilePicture: json["profilePicture"],
        isActive: json["is_active"],
        sex: json["sex"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
      );
}

class UserPModel extends UserPEntity {
  const UserPModel({
    required super.firstName,
    required super.lastName,
    required super.email,
  });
//   const UserModel({
//     required firstName,
//     required lastName,
//     required email,
// }):super(
//     firstName: firstName,
//     lastName: lastName,
//     email: email
//   );

  factory UserPModel.fromMap(Map<String, dynamic> json) => UserPModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );
}
