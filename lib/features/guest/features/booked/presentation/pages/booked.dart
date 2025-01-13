import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/widgets/booked_card.dart';

import '../../../../../../core/utils/get_token.dart';

class Booked extends StatelessWidget {
  const Booked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: ColorConstant.primaryColor,
          color: Colors.white,
          onRefresh: ()async{
            context.read<BookedBloc>().add(GetMyBookingEvent());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Column(
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
                  child:
                  BlocBuilder<BookedBloc, BookedState>(
              builder: (context, state) {
                if(state is MyBookingLoadingState){
            return Center(child: CupertinoActivityIndicator(),);
                }
                if(state is MyBookingLoadedState){
             if(state.booking.results!.isEmpty){
               return EmpityBooked();

             }
             return ListView.builder(
               padding: EdgeInsets.all(10),
               itemCount: state.booking.results!.length,
               itemBuilder: (context, index) => GestureDetector(
                   onTap: ()async{
                     final token= await GetToken().getUserToken();
                     context.goNamed('bookedDetail',pathParameters: {'token': token},extra: state.booking.results![index]);
                   },
                   child:
                 BookedCard(
                   width: MediaQuery.of(context).size.width,
                   height: 400,
                   property:state.booking.results![index],
                 ),
               ),
             );
                }
                return SizedBox.shrink();

              },
            ),
                ),
              ],
            ),
          ),
        ),
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
              Image.asset("assets/icons/Inboxe.png",
                width: 80,
                height: 80,
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
