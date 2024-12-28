import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/custom_text_field.dart';

import '../../../../../../core/common/custom_button.dart';
import '../../../../../host/features/properties/presentation/widgets/search_filed.dart';
import '../widgets/popular_house_card.dart';
import '../widgets/section_header_text.dart';

class HouseTypeDetail extends StatelessWidget {
  const HouseTypeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: SearchField(
                          prifixIcon: Icon(Icons.search),
                          onTextChnage: (value) {},
                        ),
                      ),
                      Badge(
                        label:Text("6"),
                        alignment: Alignment.topRight,
                        offset: Offset(0.0,10.0),
                        isLabelVisible:true,
                        child: IconButton(
                          iconSize: 33,
                          icon: Icon(Icons.filter_list),
                          onPressed: () =>
                              showModalBottomSheet(
                            context: context,
                            showDragHandle: false,
                            backgroundColor: Colors.white,
                            useSafeArea: true,
                            isDismissible: true,
                            isScrollControlled: true,
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)
                                )
                              ),

                              height: MediaQuery.of(context).size.height,
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  spacing: 15,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            tr('Filter Houses'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () => context.pop(),
                                              icon: Icon(
                                                Icons.cancel,
                                                color: ColorConstant.red,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Expanded(child: ListView(children: [
                                      SizedBox(
                                        height: 80,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) => Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            spacing: 4,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15),
                                                margin: EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                  color: ColorConstant.cardGrey,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.house,color: ColorConstant.secondBtnColor.withValues(alpha: 0.6),),
                                              ),
                                              Text(
                                                index.isEven ? "private House" : "pension",
                                                style: Theme.of(context).textTheme.bodySmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SecctionHeader(title: tr("Price range"), isSeeMore: false),
                                      ),
                                      RangeSlider(
                                        values: RangeValues(100, 3000),
                                        labels: RangeLabels("min", "max"),
                                        activeColor: ColorConstant.primaryColor,
                                        inactiveColor: Colors.grey,
                                        min: 100,
                                        max: 3000,
                                        divisions: 300,
                                        onChanged: (value) {
                                          print(value);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                                    decoration:BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        border:Border.all(
                                                          color: ColorConstant.secondBtnColor,
                                                        )
                                                    ),
                                                    child: Text("100 ETB")),
                                                Text(tr('Minimum'),style: Theme.of(context).textTheme.bodySmall,),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                                    decoration:BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        border:Border.all(
                                                          color: ColorConstant.secondBtnColor,

                                                        )

                                                    ),
                                                    child: Text("100 ETB")),
                                                Text(tr('Maximum'),style: Theme.of(context).textTheme.bodySmall,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SecctionHeader(title: tr("Location"), isSeeMore: false),
                                      ),
                                      CustomTextField(hintText:tr("Addis Ababa"),
                                          surfixIcon:PopupMenuButton<String>(
                                            icon: Icon(Icons.arrow_drop_down),
                                            onSelected: (String value) {},
                                            color: Colors.white,
                                            itemBuilder: (BuildContext context) {
                                              return [
                                                PopupMenuItem(
                                                    value: "English", child: Text("English")),
                                                PopupMenuItem(value: "አማርኛ", child: Text("አማርኛ")),
                                                PopupMenuItem(
                                                    value: "Afan Oromo", child: Text("Afan Oromo")),
                                              ];
                                            },
                                          ),
                                          onTextChnage:(value){},
                                          isMultiLine:false,
                                          textInputType:TextInputType.text),
                                      CheckboxListTile(
                                        activeColor: ColorConstant.green,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        value: true,
                                        title:Text(tr('Nearby Search'),style: Theme.of(context).textTheme.bodyMedium,),
                                        onChanged: (value) {

                                        },),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          spacing: 15,
                                          children: [
                                            Expanded(
                                                child: CustomButton(
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        padding: EdgeInsets.all(20),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15),
                                                            side: BorderSide(
                                                                color: ColorConstant.secondBtnColor))),
                                                    child: Text(
                                                      tr("Clear all"),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                          color: ColorConstant.secondBtnColor,
                                                          fontWeight: FontWeight.w600),
                                                    ))),
                                            Expanded(
                                                child: CustomButton(
                                                    onPressed: () {

                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ColorConstant.primaryColor,
                                                      padding: EdgeInsets.all(20),
                                                    ),
                                                    child: Text(
                                                      tr("Show"),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600),
                                                    )))
                                          ],
                                        ),
                                      )
                                    ],))

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
            child:
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SecctionHeader(
                  title: tr("Most Popular"),
                  isSeeMore: true,
                ),
              ),
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.goNamed('houseDetail'),
                    child: PopularHouseCard(
                      width: 300,
                      height: 300,
                      hasStatus: false,
                    ),
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                padding: EdgeInsets.all(4),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => context.goNamed('houseDetail'),
                    child: PopularHouseCard(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      hasStatus: false,
                    ),
                  );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
