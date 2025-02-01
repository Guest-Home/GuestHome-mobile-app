
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


 GpropertyEntity copyWith({
   List<ResultEntity>? results,
   dynamic next,
   int? count,
   String? previous,
 }) {
   return GpropertyEntity(
     results: results ?? this.results,
     next: next,
     count: count ?? this.count,
     previous: previous ?? this.previous,
   );
 }

  @override
  List<Object?> get props =>[count,next,previous,results];
}

class ResultEntity extends Equatable {
 final int? id;
 final int? price;
 final String? title;
 final  String? unit;
 final  String? typeofHouse;
 final String? description;
 final String? city;
 final PostedByEntity? postedBy;
 final List<HouseImageEntity>? houseImage;
 final String? subDescription;
 final String? specificAddress;

  const ResultEntity({
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
  final String? typeOfCustomer;
  final int? rating;
  final String? language;
  final String?profilePicture;

  const PostedByEntity({
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
 final int? id;
 final String? firstName;
 final String? lastName;

  const UserAccountEntity({
    this.id,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props =>[id,firstName,lastName];

}
