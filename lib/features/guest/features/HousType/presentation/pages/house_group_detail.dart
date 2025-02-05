
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/model/house_detail_argument.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/guest_property_entity.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/utils/get_token.dart';
import '../widgets/house_group_card.dart';

class HouseGroupDetail extends StatelessWidget {
  const HouseGroupDetail({super.key,required this.house});

  final ResultEntity house;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text(house.houses![0].title!,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14
            ),),
            Expanded(
              child: ListView.builder(
                itemCount: house.houses!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()async{
                      final token = await GetToken().getUserToken();
                      context.push('/houseDetail/$token', extra:HouseDetailArguments(
                        profilePicture: house.profilePicture??"",
                          property: house.houses![index], userAccountEntity:house.userAccount!));
                    },
                    child: HouseGroupCard(
                      houseEntity: house.houses![index],
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      userAccountEntity: house.userAccount!,
                      rating: house.rating,
                    ),
                  );
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
