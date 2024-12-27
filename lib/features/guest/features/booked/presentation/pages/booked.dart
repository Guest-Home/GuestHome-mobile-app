import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
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
          Padding(
              padding: EdgeInsets.all(1),
              child: ListTile(
                title: SecctionHeader(title: tr("Booked"), isSeeMore: false),
                subtitle: Text(
                  "Here is the list of your requested booking",
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              )),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => context.goNamed('bookedDetail'),
                child: PopularHouseCard(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  hasStatus: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmpityBooked extends StatelessWidget {
  const EmpityBooked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty.svg',
            semanticsLabel: 'empity',
            fit: BoxFit.cover,
          ),
          Text(
            "You didn’t booked any Properties.  search and book properties. ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          CustomButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: ColorConstant.secondBtnColor))),
              child: Text(
                "Search properties ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
