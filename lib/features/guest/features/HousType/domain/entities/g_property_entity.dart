
import 'package:equatable/equatable.dart';

class GpropertyEntity extends Equatable {
 final int? count;
 final dynamic next;
 final dynamic previous;
 final List<ResultEntity>? results;

 const GpropertyEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  @override
  List<Object?> get props =>[count,next,previous,results];
}

class ResultEntity extends Equatable {
  int? id;
  int? price;
  String? title;
  String? unit;
  String? typeofHouse;
  String? description;
  String? city;
  PostedByEntity? postedBy;
  List<HouseImageEntity>? houseImage;
  String? subDescription;
  String? specificAddress;

  ResultEntity({
    this.id,
    this.price,
    this.title,
    this.unit,
    this.typeofHouse,
    this.description,
    this.city,
    this.postedBy,
    this.houseImage,
    this.subDescription,
    this.specificAddress,
  });

  @override
  List<Object?> get props =>[id,price,title,unit,typeofHouse,description,unit,city,postedBy,houseImage,subDescription,specificAddress];

}

class HouseImageEntity extends Equatable {
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
  UserAccountEntity? userAccount;
  String? typeOfCustomer;
  int? rating;
  String? language;
  String?profilePicture;

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

class UserAccountEntity extends Equatable {
  int? id;
  String? firstName;
  String? lastName;

  UserAccountEntity({
    this.id,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props =>[id,firstName,lastName];

}
