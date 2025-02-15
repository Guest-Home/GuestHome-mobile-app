

import 'package:equatable/equatable.dart';

class MyBookingEntity extends Equatable{

 final int? count;
 final dynamic next;
 final dynamic previous;
 final List<ResultBookingEntity>? results;

  const MyBookingEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
 MyBookingEntity copyWith({
   List<ResultBookingEntity>? results,
   dynamic next,
   int? count,
   String? previous,
 }) {
   return MyBookingEntity(
     results: results ?? this.results,
     next: next,
     count: count ?? this.count,
     previous: previous ?? this.previous,
   );
 }

  @override
  List<Object?> get props =>[count,next,previous,results];

}

class ResultBookingEntity extends Equatable{
  final int? id;
  final HouseEntity? house;
  //final UserEntity? user;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String ?status;
  final dynamic decisionTime;
  final dynamic assignedRoom;

  const ResultBookingEntity({
    this.id,
    this.house,
   // this.user,
    this.checkIn,
    this.checkOut,
    this.status,
    this.decisionTime,
    this.assignedRoom
  });

  @override
  List<Object?> get props =>[id,house,checkOut,checkIn,status,decisionTime,assignedRoom];
}
class HouseEntity extends Equatable {
  final  int? id;
  final  int? price;
  final String? title;
  final String? unit;
  final String? typeofHouse;
  final String? city;
  final PostedByEntity? postedBy;
  final List<HouseImageEntity>? houseImage;
  final String? subDescription;
  final String? specificAddress;
  final String? description;

  const HouseEntity({
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
  final PostedByUserAccountEntity? userAccount;
  final String? typeOfCustomer;
  final int? rating;
  final String? language;
  final String? profilePicture;
  final bool? isPaymentRequired;

  const PostedByEntity({
    this.id,
    this.userAccount,
    this.typeOfCustomer,
    this.rating,
    this.language,
    this.profilePicture,
    this.isPaymentRequired
  });

  @override
  List<Object?> get props =>[id,userAccount,typeOfCustomer,rating,language,profilePicture,isPaymentRequired];
}
class PostedByUserAccountEntity extends Equatable {
  final  int? id;
  final  String? firstName;
  final String? lastName;

  const PostedByUserAccountEntity({
    this.id,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props =>[id,firstName,lastName];
}

// class UserEntity extends Equatable {
//   final int? id;
//   final UserUserAccountEntity? userAccount;
//   final String? phoneNumber;
//   final dynamic chatId;
//
//   const UserEntity({
//     this.id,
//     this.userAccount,
//     this.phoneNumber,
//     this.chatId,
//   });
//
//   @override
//   List<Object?> get props =>[id,userAccount,phoneNumber,chatId];
// }

// class UserUserAccountEntity extends Equatable {
//   final int? id;
//   final String? username;
//   final String? email;
//   final String? firstName;
//   final String? lastName;
//   final bool? isStaff;
//
//   const UserUserAccountEntity({
//     this.id,
//     this.username,
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.isStaff,
//   });
//
//   @override
//   List<Object?> get props =>[id,username,email,firstName,lastName,isStaff];
// }