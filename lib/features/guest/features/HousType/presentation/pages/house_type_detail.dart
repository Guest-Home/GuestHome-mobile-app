import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                        child: searchField(
                          onTextChnage: (value) {},
                        ),
                      ),
                      Badge(
                        child: IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            backgroundColor: Colors.white,
                            useSafeArea: true,
                            builder: (context) => Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height,
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
                  title: "Most Popular",
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
                  title: "Nearby your location",
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
