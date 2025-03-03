

import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_detail.dart';

class BookedDetailModel extends BookedDetailEntity {
  const BookedDetailModel({
    required super.id,
    required super.user,
    required super.checkIn,
    required super.checkOut,
    required super.decisionTime,
    required super.house,
    required super.status,
  });

  factory BookedDetailModel.fromMap(Map<String, dynamic> json) => BookedDetailModel(
    id: json["id"],
    house: HouseDetailModel.fromMap(json["house"]),
    user: UserDetailModel.fromMap(json["user"]),
    checkIn: DateTime.parse(json["checkIn"]),
    checkOut: DateTime.parse(json["checkOut"]),
    status: json["status"],
    decisionTime: DateTime.parse(json["decisionTime"]),
  );
}

class HouseDetailModel extends HouseDetailEntity {
  const HouseDetailModel({
    required super.id,
    required super.price,
    required super.city,
    required super.description,
    required super.houseImage,
    required super.latitude,
    required super.longitude,
    required super.postedBy,
    required super.postedOn,
    required super.specificAddress,
    required super.subDescription,
    required super.title,
    required super.typeofHouse,
    required super.unit,
  });

  factory HouseDetailModel.fromMap(Map<String, dynamic> json) => HouseDetailModel(
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
    postedBy: PostedByDetailModel.fromMap(json["postedBy"]),
    houseImage: List<HouseImageDetailModel>.from(json["houseImage"].map((x) => HouseImageDetailModel.fromMap(x))),
    subDescription: json["sub_description"],
    specificAddress: json["specificAddress"],
  );
}

class HouseImageDetailModel extends HouseImageDetailEntity {
  const HouseImageDetailModel({
    required super.id,
    required super.image,
    required super.house,
  });

  factory HouseImageDetailModel.fromMap(Map<String, dynamic> json) => HouseImageDetailModel(
    id: json["id"],
    image: json["image"],
    house: json["house"],
  );
}

class PostedByDetailModel extends PostedByDetailEntity {

  const PostedByDetailModel({
    required super.id,
    required super.userAccount,
    required super.phoneNumber,
    required super.profilePicture,
    required super.typeOfCustomer,
    required super.rating,
    required super.chatId,
    required super.isApproved,
    required super.points,
    required super.gender,
   // required super.agent,
    required super.language,
  });

  factory PostedByDetailModel.fromMap(Map<String, dynamic> json) => PostedByDetailModel(
    id: json["id"],
    userAccount:json["userAccount"]!=null? UserAccountDetailModel.fromMap(json["userAccount"]):null,
    phoneNumber: json["phoneNumber"],
    profilePicture: json["profilePicture"],
    typeOfCustomer: json["typeOfCustomer"],
    rating: json["rating"],
    chatId: json["chatId"],
    isApproved: json["is_approved"],
    points: json["points"],
    gender: json["gender"],
   // agent: AgentDetailModel.fromMap(json["agent"]),
    language: json["language"],
  );
}

class UserAccountDetailModel extends UserAccountDetailEntity {
  const UserAccountDetailModel({
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.isStaff,
  });

  factory UserAccountDetailModel.fromMap(Map<String, dynamic> json) => UserAccountDetailModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isStaff: json["is_staff"],
  );

}
class UserDetailModel extends UserDetailEntity {
  const UserDetailModel({
    required super.id,
    required super.userAccount,
    required super.phoneNumber,
    required super.chatId,
  });

  factory UserDetailModel.fromMap(Map<String, dynamic> json) => UserDetailModel(
    id: json["id"],
    userAccount: UserAccountDetailModel.fromMap(json["userAccount"]),
    phoneNumber: json["phoneNumber"],
    chatId: json["chatId"],
  );

}


class AgentDetailModel extends AgentDetailEntity {

   const AgentDetailModel({
   required super.id,
     required super.user,
     required super.profilePicture,
     required super.document,
     required super.isActive,
     required super.sex,
     required super.phoneNumber,
     required super.city,
     required super.bank,
     required super.createdAt,
     required super.modifiedAt,
  });

  factory AgentDetailModel.fromMap(Map<String, dynamic> json) => AgentDetailModel(
    id: json["id"],
    user: AgentUser.fromMap(json["user"]),
    profilePicture: json["profilePicture"],
    document: json["document"],
    isActive: json["is_active"],
    sex: json["sex"],
    phoneNumber: json["phoneNumber"],
    city: json["city"],
    bank: List<Bank>.from(json["bank"].map((x) => Bank.fromMap(x))),
    createdAt:json["created_at"],
    modifiedAt:json["modified_at"],
  );
}

class Bank extends BankEntity{
  final int? id;
  final String? bankName;
  final String? accountNumber;

  const Bank({
    this.id,
    this.bankName,
    this.accountNumber,
  });

  factory Bank.fromMap(Map<String, dynamic> json) => Bank(
    id: json["id"],
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
  );

  @override
  List<Object?> get props =>[id,bankName,accountNumber];
}

class AgentUser extends AgentUserEntity{

  const AgentUser({
    required super.firstName,
    required super.lastName,
    required super.email,
  });

  factory AgentUser.fromMap(Map<String, dynamic> json) => AgentUser(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
  );
}