
import 'package:equatable/equatable.dart';

class BookedDetailEntity extends Equatable {
  final int? id;
  final HouseDetailEntity? house;
  final UserDetailEntity? user;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? status;
  final DateTime? decisionTime;

  const BookedDetailEntity({
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
  final  int? id;
  final  int? price;
  final  String? title;
  final String? unit;
  final String? latitude;
  final String? longitude;
  final String? typeofHouse;
  final String? description;
  final String? postedOn;
  final String? city;
  final PostedByDetailEntity? postedBy;
  final List<HouseImageDetailEntity>? houseImage;
  final  String? subDescription;
  final String? specificAddress;

  const HouseDetailEntity({
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
  final int? id;
  final String? image;
  final int? house;

  const HouseImageDetailEntity({
    this.id,
    this.image,
    this.house,
  });

  @override
  List<Object?> get props =>[id,image,house];
}

class PostedByDetailEntity extends Equatable {
  final int? id;
  final UserAccountDetailEntity? userAccount;
  final  String? phoneNumber;
  final String? profilePicture;
  final String? typeOfCustomer;
  final int? rating;
  final dynamic chatId;
  final  bool? isApproved;
  final  String? points;
  final String? gender;
  final  AgentDetailEntity? agent;
  final String? language;

  const PostedByDetailEntity({
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
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final bool? isStaff;

  const UserAccountDetailEntity({
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
  final int? id;
  final UserAccountDetailEntity? userAccount;
  final String? phoneNumber;
  final dynamic chatId;

  const UserDetailEntity({
    this.id,
    this.userAccount,
    this.phoneNumber,
    this.chatId,
  });

  @override
  List<Object?> get props =>[id,userAccount,phoneNumber,chatId];
}

class AgentDetailEntity extends Equatable {
 final int? id;
 final AgentUserEntity? user;
 final String? profilePicture;
 final String? document;
 final bool? isActive;
 final String? sex;
 final  String? phoneNumber;
 final  String? city;
 final List<BankEntity>? bank;
 final String? createdAt;
 final String? modifiedAt;

  const AgentDetailEntity({
    this.id,
    this.user,
    this.profilePicture,
    this.document,
    this.isActive,
    this.sex,
    this.phoneNumber,
    this.city,
    this.bank,
    this.createdAt,
    this.modifiedAt,
  });


  @override
  List<Object?> get props =>[id,user,profilePicture,document,isActive,sex,phoneNumber,city,bank,createdAt,modifiedAt];
}

class BankEntity extends Equatable{
 final int? id;
 final String? bankName;
 final String? accountNumber;

  const BankEntity({
    this.id,
    this.bankName,
    this.accountNumber,
  });

  @override
  List<Object?> get props =>[id,bankName,accountNumber];
}

class AgentUserEntity extends Equatable{
  final String? firstName;
 final String? lastName;
 final String? email;

  const AgentUserEntity({
    this.firstName,
    this.lastName,
    this.email,
  });

  @override
  List<Object?> get props =>[firstName,lastName,email];
}