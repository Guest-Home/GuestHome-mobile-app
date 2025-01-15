import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import '../../../properties/presentation/widgets/search_filed.dart';
import '../widgets/request_card.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: RefreshIndicator(
        backgroundColor: ColorConstant.primaryColor,
        color: Colors.white,
        onRefresh: () async {
          context.read<RequestBloc>().add(GetReservationEvent());
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
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
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                title: Container(
                  padding: EdgeInsets.all(10),
                  child: SearchField(
                    prifixIcon: Icon(Icons.search),
                    onTextChnage: (value) {},
                  ),
                ),
              ),
            ),
            BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                if (state is ReservationLoadingState) {
                  return SliverToBoxAdapter(
                      child: Center(
                    child: CupertinoActivityIndicator(),
                  ));
                } else if (state is ReservationLoadedState) {
                  if (state.reservation.results!.isEmpty) {
                    return SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 15,
                        children: [
                        Image.asset("assets/icons/Inboxe.png",
                          width: 80,
                          height: 80,
                        ),
                      Text(
                        "no reservation found",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16
                        ),
                      ),
                      ],
                    ),
                )
                    ));
                  } else {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => GestureDetector(
                                onTap: () {
                                  reservationBottomSheet(context, state, index);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: RequestCard(
                                    isEditing: false,
                                    reservationEntity:
                                        state.reservation.results![index],
                                  ),
                                ),
                              ),
                          childCount: state.reservation.results!.length),
                    );
                  }
                }
                return SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              },
            )
          ],
        ),
      )),
    );
  }

  PersistentBottomSheetController reservationBottomSheet(
      BuildContext context, ReservationLoadedState state, int index) {
    return showBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height - 100,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RequestCard(
              isEditing: true,
              reservationEntity: state.reservation.results![index],
            ),
          ],
        ),
      ),
    );
  }
}
