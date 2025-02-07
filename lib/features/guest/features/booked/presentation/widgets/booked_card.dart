import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/enum/reservation_status_enum.dart';
import '../../../../../../core/utils/get_token.dart';

class BookedCard extends StatelessWidget {
  const BookedCard({
    super.key,
    required this.width,
    required this.height,
    required this.property,
  });

  final double width;
  final double? height;
  final ResultBookingEntity property;

  BookingStatus getStatus(String status) {
    switch (status) {
      case 'Waiting for Approval':
        return BookingStatus.pending;
      case 'Approved':
        return BookingStatus.approved;
      case 'Rejected':
        return BookingStatus.rejected;
      default:
        return BookingStatus.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        final token = await GetToken().getUserToken();
        if(getStatus(property.status!)==BookingStatus.approved){
          context.goNamed('bookedDetail',
              pathParameters: {'token': token},
              extra:property.id);
        }else{
          context.goNamed('bookedDetailNonApproved',
              pathParameters: {'token': token},
              extra:property);
        }
      },
      child: Container(
        width: width,
        height: MediaQuery.of(context).size.height * 0.5,
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: AbsorbPointer(
                absorbing: true,
                child: CarouselView(
                    elevation: 0,
                    padding: EdgeInsets.all(0),
                    reverse: true,
                    backgroundColor: ColorConstant.cardGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemExtent: MediaQuery.of(context).size.width,
                    children: List.generate(
                      property.house!.houseImage!.length,
                      (index) => ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: property.house!.houseImage![index].image!,
                          placeholder: (context, url) => Icon(
                            Icons.photo,
                            color: Colors.black12,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                      ),
                    )),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: [
                  Text(
                    property.house!.title!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 2,
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: ColorConstant.yellow,
                      ),
                      Text(
                        "${property.house!.postedBy!.rating}/5.0",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 7,
                children: [
                  Text(property.house!.subDescription!.toString(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.secondBtnColor
                              .withValues(alpha: 0.4))),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: tr("posted by"),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 0.4))),
                    TextSpan(
                        text:
                            " @${property.house!.postedBy!.userAccount!.firstName} ${property.house!.postedBy!.userAccount!.lastName}",
                        style: TextStyle(
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 1)))
                  ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text:
                                "${property.house!.price} ${property.house!.unit} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.secondBtnColor)),
                        TextSpan(
                            text: tr("/ day"),
                            style: TextStyle(
                                color: ColorConstant.secondBtnColor
                                    .withValues(alpha: 0.7))),
                      ])),
                      // Text(
                      //   "1.3km away",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodySmall!
                      //       .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                      // )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 21,
                        color: ColorConstant.secondBtnColor,
                      ),
                      Expanded(
                        child: Text(
                          "${property.house!.city!}, ${property.house!.specificAddress!}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorConstant.secondBtnColor),
                        ),
                      )
                    ],
                  )
                ],

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:3),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("Booking Status"),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Expanded(
                      child: StatusButton(
                    status: getStatus(property.status.toString()),
                  ))
                ],
              ),
            ),
            if(property.assignedRoom!=null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:3,vertical: 10),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Room Number",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Text(property.assignedRoom,  style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 14),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  const StatusButton({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: CustomButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: status.backgroundColor,
          padding: EdgeInsets.all(1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: Text(
          status.name,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
    );
  }
}
