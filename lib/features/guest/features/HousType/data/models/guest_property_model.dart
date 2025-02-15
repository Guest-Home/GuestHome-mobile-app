
import 'package:minapp/features/guest/features/HousType/domain/entities/guest_property_entity.dart';


class GuestPropertyModel extends GuestPropertyEntity {
  const GuestPropertyModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory GuestPropertyModel.fromMap(Map<String, dynamic> json) => GuestPropertyModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<ResultModel>.from(json["results"].map((x) => ResultModel.fromMap(x))),
  );

}

class ResultModel extends ResultEntity  {
  const ResultModel({
   required super.id,
   required super.userAccount,
   required super.typeOfCustomer,
   required super.tumbleImage,
   required super.rating,
   required super.language,
   required super.profilePicture,
   required super.isPaymentRequired,
   required super.houses,
  });

  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
    id: json["id"],
    userAccount: UserAccountModel.fromMap(json["userAccount"]),
    typeOfCustomer:json["typeOfCustomer"],
    tumbleImage: json["tumble_image"],
    rating: json["rating"],
    language:json["language"],
    profilePicture: json["profilePicture"],
    isPaymentRequired: json["is_payment_required"],
    houses: List<HouseModel>.from(json["houses"].map((x) => HouseModel.fromMap(x))),
  );
}

class HouseModel extends HouseEntity {
  const HouseModel({
    required super.id,
    required super.price,
    required super.title,
    required super.unit,
    required super.typeofHouse,
    required super.description,
    required super.city,
    required super.houseImage,
    required super.subDescription,
    required super.specificAddress,
  });

  factory HouseModel.fromMap(Map<String, dynamic> json) => HouseModel(
    id: json["id"],
    price: json["price"],
    title: json["title"],
    unit:json["unit"],
    typeofHouse:json["typeofHouse"],
    description: json["description"],
    city:json["city"],
    houseImage: List<HouseImageModel>.from(json["houseImage"].map((x) => HouseImageModel.fromMap(x))),
    subDescription: json["sub_description"],
    specificAddress: json["specificAddress"],
  );

}


class HouseImageModel extends HouseImageEntity {
  const HouseImageModel({
    required super.id,
    required super.image,
    required super.house,
    required super.order,
  });

  factory HouseImageModel.fromMap(Map<String, dynamic> json) => HouseImageModel(
    id: json["id"],
    image: json["image"],
    house: json["house"],
    order: json["order"],
  );

}

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required super.id,
    required super.firstName,
    required super.lastName,
  });

  factory UserAccountModel.fromMap(Map<String, dynamic> json) => UserAccountModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

}
