// import 'dart:convert';

// List<Property> propertyFromMap(String str) => List<Property>.from(json.decode(str).map((x) => Property.fromMap(x)));

// String propertyToMap(List<Property> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';

class PropertyModel extends PropertyEntity {
   const PropertyModel({
    required id,
    required price,
    required title,
    required unit,
    required latitude,
    required longitude,
    required typeofHouse,
    required description,
    required postedOn,
    required numberOfRoom,
    required city,
    required isApproved,
    required published,
    required messageId,
    required postedBy,
    required houseImage,
    required subDescription,
    required specificAddress,
  }) : super(
          id: id,
          price: price,
          title: title,
          unit: unit,
          latitude: latitude,
          longitude: longitude,
          typeofHouse: typeofHouse,
          description: description,
          postedOn: postedOn,
          numberOfRoom: numberOfRoom,
          city: city,
          isApproved: isApproved,
          published: published,
          messageId: messageId,
          postedBy: postedBy,
          houseImage: houseImage,
          subDescription: subDescription,
          specificAddress: specificAddress,
        );

  factory PropertyModel.fromMap(Map<String, dynamic> json) => PropertyModel(
        id: json["id"],
        price: json["price"],
        title: json["title"],
        unit: json["unit"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        typeofHouse: json["typeofHouse"],
        description: json["description"],
        postedOn: DateTime.parse(json["postedOn"]),
        numberOfRoom: json["number_of_room"],
        city: json["city"],
        isApproved: json["is_approved"],
        published: json["published"] != null
            ? DateTime.parse(json["published"])
            : null,
        messageId: json["messageId"],
        postedBy: PostedByModel.fromMap(json["postedBy"]),
        houseImage: List<HouseImageModel>.from(
            json["houseImage"].map((x) => HouseImageModel.fromMap(x))),
        subDescription: json["sub_description"]?.toString().split(',').toList(),
        specificAddress: json["specificAddress"],
      );
}

class HouseImageModel extends HouseImageEntity {
  const HouseImageModel({required id, required image, required house})
      : super(id: id, image: image, house: house);

  factory HouseImageModel.fromMap(Map<String, dynamic> json) => HouseImageModel(
        id: json["id"],
        image: json["image"],
        house: json["house"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "house": house,
      };
}

class PostedByModel extends PostedByEntity {
  const PostedByModel(
      {required id,
      required userModel,
      required phoneNumber,
      required profilePicture,
      required typeOfCustomer,
      required rating,
      required chatId,
      required isApproved,
      required points,
      required gender,
      required agentModel,
      required language})
      : super(
            id: id,
            userAccount: userModel,
            phoneNumber: phoneNumber,
            profilePicture: profilePicture,
            typeOfCustomer: typeOfCustomer,
            rating: rating,
            chatId: chatId,
            isApproved: isApproved,
            points: points,
            gender: gender,
            agent: agentModel,
            language: language);

  factory PostedByModel.fromMap(Map<String, dynamic> json) => PostedByModel(
        id: json["id"],
        userModel: UserModel.fromMap(json["userAccount"]),
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
        typeOfCustomer: json["typeOfCustomer"],
        rating: json["rating"],
        chatId: json["chatId"] ?? '',
        isApproved: json["is_approved"],
        points: json["points"],
        gender: json["gender"],
        agentModel:
            json['agent'] != null ? AgentModel.fromMap(json["agent"]) : null,
        language: json["language"],
      );
}

class AgentModel extends AgentEntity {
  const AgentModel(
      {required id,
      required userModel,
      required profilePicture,
      required document,
      required isActive,
      required sex,
      required phoneNumber,
      required city})
      : super(
            id: id,
            user: userModel,
            profilePicture: profilePicture,
            document: document,
            isActive: isActive,
            sex: sex,
            phoneNumber: phoneNumber,
            city: city);
  factory AgentModel.fromMap(Map<String, dynamic> json) => AgentModel(
        id: json["id"],
        userModel: UserModel.fromMap(json["user"]),
        profilePicture: json["profilePicture"],
        document: json["document"],
        isActive: json["is_active"],
        sex: json["sex"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
      );
}

class UserModel extends UserEntity {
  const UserModel({required firstName, required lastName, required email})
      : super(firstName: firstName, lastName: lastName, email: email);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );
}
