import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/host/features/properties/presentation/widgets/search_filed.dart';
import 'package:minapp/features/search/presentation/bloc/search_bloc.dart';

import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/loading_indicator_widget.dart';
import '../../../../core/utils/get_token.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(
        ),
      ),
      body: Padding(padding: EdgeInsets.all(16),
        child:Column(
          spacing: 10,
          children: [
            SearchField(onTextChnage: (value) {
            if(GoRouter.of(context).routerDelegate.state!.name=='search'){
              context.read<SearchBloc>().add(SearchPropertyEvent(name: value));
            }else{
              context.read<SearchBloc>().add(HostSearchPropertyEvent(name: value));
            }
            }, surfixIcon: Icon(Icons.cancel_outlined,size: 18,),
              prifixIcon: Icon(Icons.search), isActive: true),

            BlocConsumer<SearchBloc, SearchState>(
              listener: (context, state) {},
              builder: (context, state) {
                if(state is SearchLoading){
                  return  loadingIndicator();
                }
                else if(state is SearchGuestLodeState){
                  if(state.property.count==0){
                    return NoSearchFound();
                  }
                  return Expanded(child: ListView.builder(
                    itemCount: state.property.results!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()async{
                          final token =
                          await GetToken().getUserToken();
                          context.push(
                            '/houseDetail/$token',
                            extra: state
                                .property.results![index],
                          );
                        },
                        child: Container(
                            padding:EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.13,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: CachedNetworkImage(
                                      imageUrl:state.property.results![index].houseImage![0].image!,
                                      placeholder: (context, url) => Icon(
                                        Icons.photo,
                                        color: ColorConstant.inActiveColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width:MediaQuery.of(context).size.height*0.15,
                                      height:MediaQuery.of(context).size.height*0.13,

                                    )
                                ),
                                Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    spacing:2,
                                    children: [
                                      Text(state.property.results![index].title!,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      ),),
                                      SizedBox(height: 1,),
                                      Row(
                                        children: [
                                          Text("${state.property.results![index].price} ${state.property.results![index].unit}",style:
                                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14
                                          ),),
                                          Text("/day",style:
                                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.secondBtnColor.withValues(alpha: 0.6),
                                              fontSize: 14
                                          ),)
                                        ],
                                      ),
                                      Row(
                                        spacing:4,
                                        children: [
                                          Icon(Icons.location_pin,size: 18,),
                                          Text(state.property.results![index].specificAddress!,style:
                                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14
                                          ),),

                                        ],
                                      ),
                                      Row(
                                        spacing:4,
                                        children: [
                                          Icon(Icons.star,color: ColorConstant.yellow,size: 18,),
                                          Text("${state.property.results![index].postedBy!.rating}/5.0 ",style:
                                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12
                                          ),),

                                        ],
                                      ),
                                    ]
                                ))

                              ],)
                        ),
                      );
                    },));
                }
                else if(state is SearchHostLodeState) {
                  if(state.properties!.isEmpty){
                    return NoSearchFound();
                  }
                  return Expanded(child: ListView.builder(
                    itemCount: state.properties!.length,
                    padding: EdgeInsets.all(6),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed('propertyDetail',
                              extra: state.properties![index]);
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: CachedNetworkImage(
                                      imageUrl: state.properties![index]
                                          .houseImage[0].image,
                                      placeholder: (context, url) =>
                                          Icon(
                                            Icons.photo,
                                            color: ColorConstant.inActiveColor,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.15,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.16,

                                    )
                                ),
                                Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    spacing: 2,
                                    children: [
                                      Text(state.properties![index].title,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      SizedBox(height: 1,),
                                      Row(
                                        children: [
                                          Text("${state.properties![index]
                                              .price} ${state.properties![index]
                                              .unit}", style:
                                          Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14
                                          ),),
                                          Text("/day", style:
                                          Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant
                                                  .secondBtnColor.withValues(
                                                  alpha: 0.6),
                                              fontSize: 14
                                          ),)
                                        ],
                                      ),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Icon(Icons.location_pin, size: 18,),
                                          Text(state.properties![index]
                                              .specificAddress, style:
                                          Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14
                                          ),),

                                        ],
                                      ),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Icon(Icons.star,
                                            color: ColorConstant.yellow,
                                            size: 18,),
                                          Text(
                                            "${state.properties![index].postedBy
                                                .rating}/5.0 ", style:
                                          Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12
                                          ),),

                                        ],
                                      ),
                                    ]
                                ))

                              ],)
                        ),
                      );
                    },));
                }
                return SizedBox.shrink();

              },
            ),
          ],
        )


      ),
    );
  }


}

class NoSearchFound extends StatelessWidget {
  const NoSearchFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/Inboxe.png",
          width: 80,
          height: 80,
        ),
        Text("Not Found!",style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18
        ),),
        Text("The property you’re searching\n is not found please search again.",
          textAlign: TextAlign.center,
          style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12
          ),),
      ],
    ),);
  }
}
