import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';
import '../widgets/request_card.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              'Request',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            floating: false,
            snap: false,
            pinned: true,
            expandedHeight: 140,
            collapsedHeight: 140,
            elevation: 0,
            shadowColor: Colors.transparent,
            scrolledUnderElevation: 10,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              title: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  cursorColor: ColorConstant.primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: ColorConstant.inActiveColor, fontSize: 14),
                    filled: true,
                    fillColor: ColorConstant.cardGrey,
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) => Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RequestCard(
                                  userName: 'John Doe',
                                  phoneNumber: '+91 9876543210',
                                  reservationId: '123456',
                                  checkIn: '12:00 PM',
                                  checkOut: '12:00 PM',
                                  propertyType: 'Villa',
                                  propertyId: '123456',
                                  unitType: '200',
                                  bookingStatus: 'Pending',
                                  updateStatus: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: RequestCard(
                        userName: 'John Doe',
                        phoneNumber: '+91 9876543210',
                        reservationId: '123456',
                        checkIn: '12:00 PM',
                        checkOut: '12:00 PM',
                        propertyType: 'Villa',
                        propertyId: '123456',
                        unitType: '200',
                        bookingStatus: 'Pending',
                        updateStatus: false,
                      ),
                    ),
                childCount: 10),
          )
        ],
      ),
    );
  }
}
