
import 'package:equatable/equatable.dart';

class ReservationEntity extends Equatable {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<ResultEntity>? results;

  const ReservationEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  @override
  List<Object?> get props =>[count,next,previous,results];
}

class ResultEntity extends Equatable {
  final int? id;
  final HouseEntity? house;
 final UserEntity? user;
 final String? checkIn;
 final String? checkOut;
 final String? status;
 final String? decisionTime;

  const ResultEntity({
    this.id,
    this.house,
    this.user,
    this.checkIn,
    this.checkOut,
    this.status,
    this.decisionTime,
  });

  @override
  List<Object?> get props =>[id,house,user,checkIn,checkOut,status,decisionTime];


}

class HouseEntity extends Equatable {
 final int? id;
  final int? price;
  final String? title;
  final String? unit;
  final String? latitude;
 final  String? longitude;
 final String? typeofHouse;
 final String? description;
  final String? postedOn;
 final String? city;
 final PostedByEntity? postedBy;
 final List<HouseImageEntity>? houseImage;
 final String? subDescription;
  final String? specificAddress;

  const HouseEntity({
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
  List<Object?> get props =>[id];

}

class HouseImageEntity extends Equatable {
 final int? id;
 final String? image;
 final int? house;

  const HouseImageEntity({
    this.id,
    this.image,
    this.house,
  });

  @override
  List<Object?> get props =>[id,image,house];

}

class PostedByEntity extends Equatable {
  final int? id;
  final UserAccountEntity? userAccount;
 final String? phoneNumber;
 final String? profilePicture;
 final String? typeOfCustomer;
 final int? rating;
 final dynamic chatId;
 final bool? isApproved;
 final String? points;
 final String? gender;
 final dynamic agent;
 final String? language;

  const PostedByEntity({
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

class UserAccountEntity extends Equatable {
  final int? id;
 final  String? username;
 final String? email;
 final String? firstName;
 final String? lastName;
 final bool? isStaff;

  const UserAccountEntity({
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

class UserEntity extends Equatable {
 final int? id;
 final UserAccountEntity? userAccount;
  final String? phoneNumber;
 final String? chatId;

  const UserEntity({
    this.id,
    this.userAccount,
    this.phoneNumber,
    this.chatId,
  });

  @override
  List<Object?> get props =>[id,userAccount,phoneNumber,chatId];

}
