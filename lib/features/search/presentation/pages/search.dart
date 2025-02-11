import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/host/features/properties/presentation/widgets/search_filed.dart';
import 'package:minapp/features/search/presentation/bloc/search_bloc.dart';
import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/loading_indicator_widget.dart';
import '../../../../core/common/spin_kit_loading.dart';

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
              if(value.isNotEmpty){
                if(GoRouter.of(context).routerDelegate.state!.name == 'search'){
                  context.read<SearchBloc>().add(SearchPropertyEvent(name: value));
                }
                else{
                  context.read<SearchBloc>().add(HostSearchPropertyEvent(name: value));
                }
              }
            },
             surfixIcon: Icon(Icons.cancel_outlined,size: 18,),
             prifixIcon: Icon(Icons.search), isActive: true),
            if(GoRouter.of(context).routerDelegate.state!.name =='search')
            BlocBuilder<SearchBloc, SearchState>(
              buildWhen: (previous, current) => previous!=current,
              builder: (context, state) {
                if(state is SearchLoading){
                  return  loadingIndicator();
                }
                  if(state.property.results==null || state.property.count==0){
                    return NoSearchFound();
                  }
                  return Expanded(child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        context.read<SearchBloc>().add(LoadMoreGuestPropertiesEvent());
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: state.property.results!.length+
                          (state is SearchGuestLoadingMoreState
                              ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >=
                            state.property.results!.length) {
                          return Center(child: loadingWithPrimary);
                        }
                        return GestureDetector(
                          onTap: (){

                            context.pushNamed("houseGroupDetail",extra: state
                                .property.results![index]);

                          },
                          child: Container(
                              padding:EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: state.property.results![index].tumbleImage==null?
                                      Container(
                                        width:MediaQuery.of(context).size.height*0.15,
                                        height:MediaQuery.of(context).size.height*0.13,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.cardGrey.withValues(alpha: 0.8)
                                        ),
                                        child:  Center(child: Icon(Icons.roofing,color:Colors.black12,size:50,),),
                                      ):
                                      CachedNetworkImage(
                                        imageUrl:state.property.results![index].tumbleImage,
                                        placeholder: (context, url) => Icon(
                                          Icons.photo,
                                          color: Colors.black12,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.image,color: Colors.black12,),
                                        fit: BoxFit.cover,
                                        width:MediaQuery.of(context).size.height*0.15,
                                        height:MediaQuery.of(context).size.height*0.13,

                                      )
                                  ),
                                  Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      spacing:2,
                                      children: [
                                        Text(state.property.results![index].houses![0].title!,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),),
                                        SizedBox(height: 1,),
                                        // Row(
                                        //   children: [
                                        //     Text("${state.property.results![index].price} ${state.property.results![index].unit}",style:
                                        //     Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        //         fontWeight: FontWeight.w700,
                                        //         fontSize: 14
                                        //     ),),
                                        //     Text("/day",style:
                                        //     Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        //         fontWeight: FontWeight.w700,
                                        //         color: ColorConstant.secondBtnColor.withValues(alpha: 0.6),
                                        //         fontSize: 14
                                        //     ),)
                                        //   ],
                                        // ),
                                        Row(
                                          spacing:4,
                                          children: [
                                            Icon(Icons.location_pin,size: 18,),
                                            Expanded(
                                              child: Text("${tr(state.property.results![index].houses![0].city!)},${state.property.results![index].houses![0].specificAddress!}",
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                style:
                                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14
                                              ),),
                                            ),

                                          ],
                                        ),
                                        Row(
                                          spacing:4,
                                          children: [
                                            Icon(Icons.star,color: ColorConstant.yellow,size: 18,),
                                            Text("${state.property.results![index].rating}/5.0 ",style:
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
                      },),
                  ));
              },
            ),
            if(GoRouter.of(context).routerDelegate.state!.name =='hostSearch')
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if(state is SearchLoading){
                    return  loadingIndicator();
                  }
                  if(state.hostProperties.isEmpty){
                    return NoSearchFound();
                  }
                    return Expanded(child:
                    ListView.builder(
                      itemCount: state.hostProperties.length,
                      padding: EdgeInsets.all(6),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed('propertyDetail',
                                extra: state.hostProperties[index]);
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              // height: MediaQuery
                              //     .of(context)
                              //     .size
                              //     .height * 0.16,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: CachedNetworkImage(
                                        imageUrl: state.hostProperties[index]
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
                                          .start,
                                      spacing: 2,
                                      children: [
                                        Text(state.hostProperties[index].title,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
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
                                            Text("${state.hostProperties[index]
                                                .price} ${state.hostProperties[index]
                                                .unit}", style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14
                                            ),),
                                            Text("/${tr('day')}", style:
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
                                            Icon(Icons.location_pin, size: 15,),
                                            Text(state.hostProperties[index]
                                                .specificAddress,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style:
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
                                              size: 15,),
                                            Text(
                                              "${state.hostProperties[index].postedBy
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
      spacing: 5,
      children: [
        Image.asset("assets/icons/Inboxe.png",
          width: 80,
          height: 80,
        ),
        Text(tr("Not Found"),style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18
        ),),
        Text(tr("The property you’re searching is not found please search again"),
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
