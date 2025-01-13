

import 'package:equatable/equatable.dart';

class MyBookingEntity extends Equatable{

  int? count;
  dynamic next;
  dynamic previous;
  List<ResultBookingEntity>? results;

  MyBookingEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  @override
  List<Object?> get props =>[count,next,previous,results];

}

class ResultBookingEntity extends Equatable{
  int? id;
  HouseEntity? house;
  UserEntity? user;
  DateTime? checkIn;
  DateTime? checkOut;
  String ?status;
  dynamic decisionTime;

  ResultBookingEntity({
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
class HouseEntity extends Equatable {
  int? id;
  int? price;
  String? title;
  String? unit;
  String? typeofHouse;
  String? city;
  PostedByEntity? postedBy;
  List<HouseImageEntity>? houseImage;
  String? subDescription;
  String? specificAddress;
  String? description;

  HouseEntity({
    this.id,
    this.price,
    this.title,
    this.unit,
    this.typeofHouse,
    this.city,
    this.postedBy,
    this.houseImage,
    this.subDescription,
    this.specificAddress,
    this.description
  });

  @override
  List<Object?> get props =>[id,price,title,unit,typeofHouse,city,postedBy,houseImage,subDescription,
    specificAddress,description];
  }

class HouseImageEntity extends Equatable{
  int? id;
  String? image;
  int? house;

  HouseImageEntity({
    this.id,
    this.image,
    this.house,
  });

  @override
  List<Object?> get props =>[id,image,house];
}

class PostedByEntity extends Equatable {
  int? id;
  PostedByUserAccountEntity? userAccount;
  String? typeOfCustomer;
  int? rating;
  String? language;
  String? profilePicture;

  PostedByEntity({
    this.id,
    this.userAccount,
    this.typeOfCustomer,
    this.rating,
    this.language,
    this.profilePicture
  });

  @override
  List<Object?> get props =>[id,userAccount,typeOfCustomer,rating,language,profilePicture];
}
class PostedByUserAccountEntity extends Equatable {
  int? id;
  String? firstName;
  String? lastName;

  PostedByUserAccountEntity({
    this.id,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props =>[id,firstName,lastName];
}

class UserEntity extends Equatable {
  int? id;
  UserUserAccountEntity? userAccount;
  String? phoneNumber;
  dynamic chatId;

  UserEntity({
    this.id,
    this.userAccount,
    this.phoneNumber,
    this.chatId,
  });

  @override
  List<Object?> get props =>[id,userAccount,phoneNumber,chatId];
}

class UserUserAccountEntity extends Equatable {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  bool? isStaff;

  UserUserAccountEntity({
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