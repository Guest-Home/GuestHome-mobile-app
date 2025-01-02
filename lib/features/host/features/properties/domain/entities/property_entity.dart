import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  final int id;
  final int price;
  final String title;
  final String unit;
  final String latitude;
  final String longitude;
  final String typeofHouse;
  final String description;
  final String postedOn;
  final int numberOfRoom;
  final String city;
  final bool isApproved;
  final String published;
  final int messageId;
  final PostedByEntity postedBy;
  final List<HouseImageEntity> houseImage;
  final String subDescription;
  final String specificAddress;

  const PropertyEntity({
    required this.id,
    required this.price,
    required this.title,
    required this.unit,
    required this.latitude,
    required this.longitude,
    required this.typeofHouse,
    required this.description,
    required this.postedOn,
    required this.numberOfRoom,
    required this.city,
    required this.isApproved,
    required this.published,
    required this.messageId,
    required this.postedBy,
    required this.houseImage,
    required this.subDescription,
    required this.specificAddress,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}

class HouseImageEntity extends Equatable {
  final int id;
  final String image;
  final int house;

  const HouseImageEntity({
    required this.id,
    required this.image,
    required this.house,
  });

  @override
  List<Object?> get props => [id, image, house];
}

class PostedByEntity extends Equatable {
  final int id;
  final UserEntity userAccount;
  final String phoneNumber;
  final String profilePicture;
  final String typeOfCustomer;
  final int rating;
  final String chatId;
  final bool isApproved;
  final String points;
  final String gender;
  final AgentEntity agent;
  final String language;

  const PostedByEntity({
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
        phoneNumber,
        profilePicture,
        typeOfCustomer,
        rating,
        chatId,
        isApproved,
        points,
        gender,
        agent,
        language
      ];
}

class AgentEntity extends Equatable {
  final int id;
  final UserEntity user;
  final String profilePicture;
  final String document;
  final bool isActive;
  final String sex;
  final String phoneNumber;
  final String city;

  const AgentEntity({
    required this.id,
    required this.user,
    required this.profilePicture,
    required this.document,
    required this.isActive,
    required this.sex,
    required this.phoneNumber,
    required this.city,
  });

  @override
  List<Object?> get props =>
      [id, user, profilePicture, document, isActive, sex, phoneNumber, city];
}

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object?> get props => [firstName, lastName, email];
}
