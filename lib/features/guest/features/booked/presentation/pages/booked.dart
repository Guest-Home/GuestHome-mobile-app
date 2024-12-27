import 'package:flutter/material.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/popular_house_card.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

class Booked extends StatelessWidget {
  const Booked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Padding(padding: EdgeInsets.all(1),
          child:ListTile(title:SecctionHeader(title: "Booked", isSeeMore: false),
          subtitle: Text(
            "Here is the list of your requested booking",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!,
          ) ,
          )
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) => PopularHouseCard(width: MediaQuery.of(context).size.width,
                height: 400, hasStatus: true,),),
          ),
        ],
      ),
    );
  }
}
