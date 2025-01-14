
ReservationModel reservationFromMap(Map<String,dynamic> str) => ReservationModel.fromMap(str);


class ReservationModel {
   int? count;
   dynamic next;
   dynamic previous;
   List<Result>? results;

   ReservationModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> json) => ReservationModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
  );

}
class Result {
  int? id;
  House? house;
  User? user;
  String? checkIn;
  String? checkOut;
  String? status;
  String? decisionTime;

  Result({
    this.id,
    this.house,
    this.user,
    this.checkIn,
    this.checkOut,
    this.status,
    this.decisionTime,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    house: House.fromMap(json["house"]),
    user: User.fromMap(json["user"]),
    checkIn:json["checkIn"],
    checkOut:json["checkOut"],
    status: json["status"],
    decisionTime:json["decisionTime"],
  );

}

class House {
  int? id;
  int? price;
  String? title;
  String? unit;
  String? latitude;
  String? longitude;
  String? typeofHouse;
  String? description;
  String? postedOn;
  String? city;
  PostedBy? postedBy;
  List<HouseImage>? houseImage;
  String? subDescription;
  String? specificAddress;

  House({
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

  factory House.fromMap(Map<String, dynamic> json) => House(
    id: json["id"],
    price: json["price"],
    title: json["title"],
    unit: json["unit"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    typeofHouse: json["typeofHouse"],
    description: json["description"],
    postedOn:json["postedOn"],
    city: json["city"],
    postedBy: PostedBy.fromMap(json["postedBy"]),
    houseImage: List<HouseImage>.from(json["houseImage"].map((x) => HouseImage.fromMap(x))),
    subDescription: json["sub_description"],
    specificAddress: json["specificAddress"],
  );

}

class HouseImage {
  int? id;
  String? image;
  int? house;

  HouseImage({
    this.id,
    this.image,
    this.house,
  });

  factory HouseImage.fromMap(Map<String, dynamic> json) => HouseImage(
    id: json["id"],
    image: json["image"],
    house: json["house"],
  );

}

class PostedBy {
  int? id;
  UserAccount? userAccount;
  String? phoneNumber;
  String? profilePicture;
  String? typeOfCustomer;
  int? rating;
  dynamic chatId;
  bool? isApproved;
  String? points;
  String? gender;
  dynamic agent;
  String? language;

  PostedBy({
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

  factory PostedBy.fromMap(Map<String, dynamic> json) => PostedBy(
    id: json["id"],
    userAccount: UserAccount.fromMap(json["userAccount"]),
    phoneNumber: json["phoneNumber"],
    profilePicture: json["profilePicture"],
    typeOfCustomer: json["typeOfCustomer"],
    rating: json["rating"],
    chatId: json["chatId"],
    isApproved: json["is_approved"],
    points: json["points"],
    gender: json["gender"],
    agent: json["agent"],
    language: json["language"],
  );
}

class UserAccount {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  bool? isStaff;

  UserAccount({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.isStaff,
  });

  factory UserAccount.fromMap(Map<String, dynamic> json) => UserAccount(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isStaff: json["is_staff"],
  );

}

class User {
  int? id;
  UserAccount? userAccount;
  String? phoneNumber;
  String? chatId;

  User({
    this.id,
    this.userAccount,
    this.phoneNumber,
    this.chatId,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    userAccount: UserAccount.fromMap(json["userAccount"]),
    phoneNumber: json["phoneNumber"],
    chatId: json["chatId"],
  );

}
