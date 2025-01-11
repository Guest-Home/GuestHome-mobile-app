import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/houstype_bloc.dart';

import '../../../../../../core/common/custom_button.dart';
import '../../../../../host/features/properties/presentation/widgets/search_filed.dart';
import '../widgets/popular_house_card.dart';
import '../widgets/section_header_text.dart';

class HouseTypeDetail extends StatefulWidget {
  const HouseTypeDetail({super.key, required this.name});

  final String name;

  @override
  State<HouseTypeDetail> createState() => _HouseTypeDetailState();
}

class _HouseTypeDetailState extends State<HouseTypeDetail> {
  @override
  void initState() {
    super.initState();
    context
        .read<HoustypeBloc>()
        .add(GetPropertyByHouseTypeEvent(name: widget.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: ColorConstant.primaryColor,
        color: Colors.white,
        onRefresh: ()async{
          context.read<HoustypeBloc>().add(GetPropertyByHouseTypeEvent(name:widget.name));

        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              snap: true,
              pinned: true,
              expandedHeight: 130,
              collapsedHeight: 130,
              elevation: 0,
              shadowColor: Colors.transparent,
              scrolledUnderElevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                title: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: SearchField(
                            prifixIcon: Icon(Icons.search),
                            onTextChnage: (value) {},
                          ),
                        ),
                        Badge(
                          label: Text("6"),
                          alignment: Alignment.topRight,
                          offset: Offset(0.0, 10.0),
                          isLabelVisible: true,
                          child: IconButton(
                            iconSize: 33,
                            icon: Icon(Icons.filter_list),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              showDragHandle: false,
                              backgroundColor: Colors.white,
                              useSafeArea: true,
                              elevation: 10,
                              isDismissible: true,
                              isScrollControlled: true,
                              enableDrag: true,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                height: MediaQuery.of(context).size.height,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    spacing: 15,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              tr('Filter Houses'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  tr("Close"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              ColorConstant.red),
                                                ),
                                                IconButton(
                                                    onPressed: () =>
                                                        context.pop(),
                                                    icon: Icon(
                                                      Icons.cancel,
                                                      color: ColorConstant.red,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: ListView(
                                        children: [
                                          SizedBox(
                                            height: 90,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: houseTypeList.length,
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  spacing: 4,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        margin: EdgeInsets.only(
                                                            right: 10),
                                                        decoration: BoxDecoration(
                                                          color: index == 0
                                                              ? ColorConstant
                                                                  .primaryColor
                                                                  .withValues(
                                                                      alpha: 0.5)
                                                              : ColorConstant
                                                                  .cardGrey,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          houseTypeIcons[
                                                              houseTypeList[
                                                                  index]]!,
                                                          semanticsLabel:
                                                              houseTypeList[
                                                                  index],
                                                          fit: BoxFit.cover,
                                                        )),
                                                    Text(
                                                      houseTypeList[index],
                                                      textAlign: TextAlign.center,
                                                      softWrap: true,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SecctionHeader(
                                                title: tr("Price range"),
                                                isSeeMore: false),
                                          ),
                                          RangeSlider(
                                            values: RangeValues(100, 3000),
                                            labels: RangeLabels("min", "max"),
                                            activeColor:
                                                ColorConstant.primaryColor,
                                            inactiveColor: Colors.grey,
                                            min: 100,
                                            max: 3000,
                                            divisions: 300,
                                            onChanged: (value) {},
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                            border: Border.all(
                                                              color: ColorConstant
                                                                  .secondBtnColor,
                                                            )),
                                                        child: Text("100 ETB")),
                                                    Text(
                                                      tr('Minimum'),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                            border: Border.all(
                                                              color: ColorConstant
                                                                  .secondBtnColor,
                                                            )),
                                                        child: Text("100 ETB")),
                                                    Text(
                                                      tr('Maximum'),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SecctionHeader(
                                                title: tr("Location"),
                                                isSeeMore: false),
                                          ),
                                          CustomTextField(
                                              hintText: tr("Addis Ababa"),
                                              surfixIcon: PopupMenuButton<String>(
                                                icon: Icon(Icons.arrow_drop_down),
                                                onSelected: (String value) {},
                                                color: Colors.white,
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return [
                                                    PopupMenuItem(
                                                        value: "English",
                                                        child: Text("English")),
                                                    PopupMenuItem(
                                                        value: "አማርኛ",
                                                        child: Text("አማርኛ")),
                                                    PopupMenuItem(
                                                        value: "Afan Oromo",
                                                        child:
                                                            Text("Afan Oromo")),
                                                  ];
                                                },
                                              ),
                                              onTextChnage: (value) {},
                                              isMultiLine: false,
                                              textInputType: TextInputType.text),
                                          CheckboxListTile(
                                            activeColor: ColorConstant.green,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            value: true,
                                            title: Text(
                                              tr('Nearby Search'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              spacing: 15,
                                              children: [
                                                Expanded(
                                                    child: CustomButton(
                                                        onPressed: () {
                                                          context.pop();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                side: BorderSide(
                                                                    color: ColorConstant
                                                                        .secondBtnColor))),
                                                        child: Text(
                                                          tr("Clear all"),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: ColorConstant
                                                                      .secondBtnColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ))),
                                                Expanded(
                                                    child: CustomButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              ColorConstant
                                                                  .primaryColor,
                                                          padding:
                                                              EdgeInsets.all(20),
                                                        ),
                                                        child: Text(
                                                          tr("Show"),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        )))
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SecctionHeader(
                    title: tr("Most Popular"),
                    isSeeMore: true,
                  ),
                ),
                SizedBox(
                  height: 0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.goNamed('houseDetail'),
                      child:Text("data")
                      // PopularHouseCard(
                      //   width: 300,
                      //   height: 300,
                      //   hasStatus: false,
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SecctionHeader(
                    title: tr('Nearby Search'),
                    isSeeMore: false,
                  ),
                ),

          BlocBuilder<HoustypeBloc, HoustypeState>(
          builder: (context, state) {
            if(state is HouseTypeLoadingState){
        return Center(child: CupertinoActivityIndicator(),);
            }
            else if(state is HouseTYpeLoadedState){
        if(state.properties.count==0){
          return Center(child: Text("no property found",style: Theme.of(context).textTheme.bodySmall,),);
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:state.properties.count,
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => context.goNamed('houseDetail'),
              child: PopularHouseCard(
                width: MediaQuery.of(context).size.width,
                height: 400,
                hasStatus: false,
                property: state.properties.results![index],
              ),
            );
          },
        );
            }
            return SizedBox.shrink();

          },
        ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
