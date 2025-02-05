
import '../../features/guest/features/HousType/domain/entities/guest_property_entity.dart';

class HouseDetailArguments {
  final HouseEntity property;
  final String? profilePicture;
  final UserAccountEntity userAccountEntity;

  HouseDetailArguments({this.profilePicture,required this.property, required this.userAccountEntity});
}
