import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
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
         appBar: AppBar(
          title: Text(
            'Request',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
          body: RefreshIndicator(
        backgroundColor: ColorConstant.primaryColor,
        color: Colors.white,
        onRefresh: () async {
          context.read<RequestBloc>().add(GetReservationEvent());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                context.goNamed("hostSearch");
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child:
                SearchField(
                  isActive: false,
                  prifixIcon: Icon(Icons.search),
                  onTextChnage: (value) {},
                ),

              ),
            ),
            BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                if (state is ReservationLoadingState) {
                  return Center(
                    child:loadingIndicator()
                  );
                }
                else if (state is ReservationErrorState) {
                  return  SizedBox(
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.error_outline,size: 25,color: ColorConstant.red,),
                            Text(
                              state.failure.message,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                  );
                }
                else if (state.reservation.results==null || state.reservation.results!.isEmpty) {
                    return  Expanded(
                      child: ListView(
                        children:[
                          SizedBox(
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
                        ),]
                      ),
                    );
                  }
                else if(state.reservation.results!=null || state.reservation.results!.isNotEmpty){
                  return Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          context.read<RequestBloc>().add(LoadMoreReservationEvent());
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: state.reservation.results!.length+
                            (state is ReservationLoadingMoreState
                                ? 1 : 0),
                        itemBuilder: (context, index){
                          if (index >=
                              state.reservation.results!.length) {
                            return Center(child: loadingWithPrimary);
                          }
                          return  GestureDetector(
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
                          );
                        }
                        ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            )
          ],
        ),
      )),
    );
  }

  PersistentBottomSheetController reservationBottomSheet(
      BuildContext context, RequestState state, int index) {
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
