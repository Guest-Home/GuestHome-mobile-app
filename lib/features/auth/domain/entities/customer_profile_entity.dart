import 'package:equatable/equatable.dart';

class CustomerProfileEntity extends Equatable {
  final int id;
   // final int userAccount;
  final String? profilePicture;
  final String phoneNumber;
  final String typeOfCustomer;
  final int rating;
  final String? chatId;
  final bool isApproved;
  final double? points;
  final int? agent;
  final String language;

  const CustomerProfileEntity({
    required this.id,
    // required this.userAccount,
    required this.profilePicture,
    required this.phoneNumber,
    required this.typeOfCustomer,
    required this.rating,
    required this.chatId,
    required this.isApproved,
    required this.points,
    required this.agent,
    required this.language,
  });

  @override
  List<Object?> get props => [
        id,
        // userAccount,
        profilePicture,
        phoneNumber,
        typeOfCustomer,
        rating,
        chatId,
        isApproved,
        points,
        agent,
        language
      ];
}
