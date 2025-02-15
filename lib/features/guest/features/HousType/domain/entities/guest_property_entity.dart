
import 'package:equatable/equatable.dart';

class GuestPropertyEntity extends Equatable {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<ResultEntity>? results;

  const GuestPropertyEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  GuestPropertyEntity copyWith({
    List<ResultEntity>? results,
    dynamic next,
    int? count,
    String? previous,
  }) {
    return GuestPropertyEntity(
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
  final UserAccountEntity? userAccount;
  final String? typeOfCustomer;
  final dynamic tumbleImage;
  final int? rating;
  final String? language;
  final dynamic profilePicture;
  final bool? isPaymentRequired;
  final List<HouseEntity>? houses;

  const ResultEntity({
    this.id,
    this.userAccount,
    this.typeOfCustomer,
    this.tumbleImage,
    this.rating,
    this.language,
    this.profilePicture,
    this.isPaymentRequired,
    this.houses,
  });

  @override
  List<Object?> get props =>[id,userAccount,typeOfCustomer,tumbleImage,rating,language,profilePicture,isPaymentRequired,houses];

}

class HouseEntity extends Equatable {
  final int? id;
  final int? price;
  final String? title;
  final String? unit;
  final String? typeofHouse;
  final String? description;
  final String? city;
  final List<HouseImageEntity>? houseImage;
  final String? subDescription;
  final String? specificAddress;

  const HouseEntity({
    this.id,
    this.price,
    this.title,
    this.unit,
    this.typeofHouse,
    this.description,
    this.city,
    this.houseImage,
    this.subDescription,
    this.specificAddress,
  });

  @override
  List<Object?> get props =>[id,price,title,unit,typeofHouse,description,city,houseImage,subDescription,specificAddress];

}

class HouseImageEntity extends Equatable {
  final int? id;
  final String? image;
  final int? house;
  final int? order;

  const HouseImageEntity({
    this.id,
    this.image,
    this.house,
    this.order,
  });

  @override
  List<Object?> get props =>[id,image,house,order];
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
