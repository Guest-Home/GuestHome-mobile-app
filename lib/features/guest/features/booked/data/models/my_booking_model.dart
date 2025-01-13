
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';

class MyBookingModel extends MyBookingEntity{
    MyBookingModel({
      required super.count,
      required super.next,
      required super.previous,
      required super.results,
});

    factory MyBookingModel.fromMap(Map<String, dynamic> json) => MyBookingModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );
}

class Result extends ResultBookingEntity{
  Result({
    required super.id,
    required super.house,
    required super.user,
    required super.checkIn,
    required super.checkOut,
    required super.status,
    required super.decisionTime,
});


  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    house: House.fromMap(json["house"]),
    user: User.fromMap(json["user"]),
    checkIn: DateTime.parse(json["checkIn"]),
    checkOut: DateTime.parse(json["checkOut"]),
    status: json["status"],
    decisionTime: json["decisionTime"],
  );
}

class House extends HouseEntity{
  House({
    required super.id,
    required super.price,
    required super.title,
    required super.unit,
    required super.typeofHouse,
    required super.city,
    required super.postedBy,
    required super.houseImage,
    required super.subDescription,
    required super.specificAddress,
    required super.description
});

  factory House.fromMap(Map<String, dynamic> json) => House(
    id: json["id"],
    price: json["price"],
    title: json["title"],
    unit: json["unit"],
    typeofHouse: json["typeofHouse"],
    city: json["city"],
    postedBy: PostedBy.fromMap(json["postedBy"]),
    houseImage: List<HouseImage>.from(json["houseImage"].map((x) => HouseImage.fromMap(x))),
    subDescription: json["sub_description"],
    specificAddress: json["specificAddress"],
    description: json["description"]
  );
}

class HouseImage extends HouseImageEntity{
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
}

class PostedBy extends PostedByEntity {
  PostedBy({
    required super.id,
    required super.userAccount,
    required super.typeOfCustomer,
    required super.rating,
    required super.language,
    required super.profilePicture
  });

  factory PostedBy.fromMap(Map<String, dynamic> json) => PostedBy(
    id: json["id"],
    userAccount: PostedByUserAccount.fromMap(json["userAccount"]),
    typeOfCustomer: json["typeOfCustomer"],
    rating: json["rating"],
    language: json["language"],
    profilePicture: json['profilePicture']
  );
}

class PostedByUserAccount extends PostedByUserAccountEntity{
  PostedByUserAccount({
    required super.id,
    required super.firstName,
    required super.lastName,
});
  factory PostedByUserAccount.fromMap(Map<String, dynamic> json) => PostedByUserAccount(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );
}
class User extends UserEntity{
  User({
    required super.id,
    required super.phoneNumber,
    required super.userAccount,
    required super.chatId,
});
  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    userAccount: UserUserAccount.fromMap(json["userAccount"]),
    phoneNumber: json["phoneNumber"],
    chatId: json["chatId"],
  );
}

class UserUserAccount extends UserUserAccountEntity{
  UserUserAccount({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.isStaff,
    required super.username,
});
  factory UserUserAccount.fromMap(Map<String, dynamic> json) => UserUserAccount(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isStaff: json["is_staff"],
  );
}
