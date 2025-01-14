
import 'package:equatable/equatable.dart';

class BookedDetailEntity extends Equatable {
  int? id;
  HouseDetailEntity? house;
  UserDetailEntity? user;
  DateTime? checkIn;
  DateTime? checkOut;
  String? status;
  DateTime? decisionTime;

  BookedDetailEntity({
    this.id,
    this.house,
    this.user,
    this.checkIn,
    this.checkOut,
    this.status,
    this.decisionTime,
  });
  @override
  List<Object?> get props =>[id,house,user,checkOut,checkIn,status,decisionTime];
}

class HouseDetailEntity extends Equatable {
  int? id;
  int? price;
  String? title;
  String? unit;
  String? latitude;
  String? longitude;
  String? typeofHouse;
  String? description;
  String? postedOn;
  String? city;
  PostedByDetailEntity? postedBy;
  List<HouseImageDetailEntity>? houseImage;
  String? subDescription;
  String? specificAddress;

  HouseDetailEntity({
    this.id,
    this.price,
    this.title,
    this.unit,
    this.latitude,
    this.longitude,
    this.typeofHouse,
    this.description,
    this.postedOn,
    this.city,
    this.postedBy,
    this.houseImage,
    this.subDescription,
    this.specificAddress,
  });

  @override
  List<Object?> get props =>[id,price,title,unit,latitude,longitude,typeofHouse,description,postedOn,city,postedBy,houseImage,subDescription,specificAddress];

}

class HouseImageDetailEntity extends Equatable {
  int? id;
  String? image;
  int? house;

  HouseImageDetailEntity({
    this.id,
    this.image,
    this.house,
  });

  @override
  List<Object?> get props =>[id,image,house];
}

class PostedByDetailEntity extends Equatable {
  int? id;
  UserAccountDetailEntity? userAccount;
  String? phoneNumber;
  String? profilePicture;
  String? typeOfCustomer;
  int? rating;
  dynamic chatId;
  bool? isApproved;
  String? points;
  String? gender;
  dynamic agent;
  String? language;

  PostedByDetailEntity({
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
  List<Object?> get props =>[id,userAccount,phoneNumber,profilePicture,typeOfCustomer,rating,chatId,isApproved,points,gender,agent,language];
}

class UserAccountDetailEntity extends Equatable {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  bool? isStaff;

  UserAccountDetailEntity({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.isStaff,
  });

  @override
  List<Object?> get props =>[id,username,email,firstName,lastName,isStaff];
}

class UserDetailEntity extends Equatable {
  int? id;
  UserAccountDetailEntity? userAccount;
  String? phoneNumber;
  dynamic chatId;

  UserDetailEntity({
    this.id,
    this.userAccount,
    this.phoneNumber,
    this.chatId,
  });

  @override
  List<Object?> get props =>[id,userAccount,phoneNumber,chatId];
}
