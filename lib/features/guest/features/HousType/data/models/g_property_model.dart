import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';

GpropertyModel gpropertyModelFromMap(Map<String, dynamic> str) =>
    GpropertyModel.fromMap(str);

class GpropertyModel extends GpropertyEntity {
  GpropertyModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory GpropertyModel.fromMap(Map<String, dynamic> json) => GpropertyModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );
}

class Result extends ResultEntity {
  Result({
    required super.id,
    required super.price,
    required super.title,
    required super.unit,
    required super.typeofHouse,
    required super.description,
    required super.city,
    required super.postedBy,
    required super.houseImage,
    required super.subDescription,
    required super.specificAddress,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        price: json["price"],
        title: json["title"],
        unit: json["unit"],
        typeofHouse: json["typeofHouse"],
        description: json["description"],
        city: json["city"],
        postedBy: PostedBy.fromMap(json["postedBy"]),
        houseImage: List<HouseImage>.from(
            json["houseImage"].map((x) => HouseImage.fromMap(x))),
        subDescription: json["sub_description"],
        specificAddress: json["specificAddress"],
      );
}

class HouseImage extends HouseImageEntity {
  HouseImage({
    required super.id,
    required super.image,
    required super.house,
  });

  factory HouseImage.fromMap(Map<String, dynamic> json) => HouseImage(
        id: json["id"],
        image: json["image"],
        house: json["house"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "house": house,
      };
}

class PostedBy extends PostedByEntity {
  PostedBy({
    required super.id,
    required super.userAccount,
    required super.typeOfCustomer,
    required super.rating,
    required super.language,
  });

  factory PostedBy.fromMap(Map<String, dynamic> json) => PostedBy(
        id: json["id"],
        userAccount: UserAccount.fromMap(json["userAccount"]),
        typeOfCustomer: json["typeOfCustomer"],
        rating: json["rating"],
        language: json["language"],
      );
}

class UserAccount extends UserAccountEntity {
  UserAccount({
    required super.id,
    required super.firstName,
    required super.lastName,
  });

  factory UserAccount.fromMap(Map<String, dynamic> json) => UserAccount(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );
}
