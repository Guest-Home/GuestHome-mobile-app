import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';

class Properties extends StatefulWidget {
  const Properties({super.key});

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Properties',
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
            title: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
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
            (context, index) => Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: ColorConstant.cardGrey.withValues(alpha: 1.6),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Placeholder(
                      fallbackHeight: 200,
                    ),
                    ListTile(
                      title: Text(
                        'Property Name',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'House Description goes here.Lorem ipsum dolor sit amet consectetur. Posuere vulputate gravida diam id feugiat. Suscipit et nunc tortor vivamus mattis sed est.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: ColorConstant.primaryColor,
                        ),
                        Text(
                          'Addis Ababa, Ethiopia',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorConstant.inActiveColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      color: ColorConstant.inActiveColor.withValues(alpha: 0.2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 7,
                          children: [
                            Icon(
                              Icons.other_houses_rounded,
                              color: ColorConstant.primaryColor,
                            ),
                            Text(
                              '10',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: ColorConstant.primaryColor),
                            ),
                          ],
                        ),
                        RichText(
                            text: TextSpan(
                          text: 'Price: ',
                          children: [
                            TextSpan(
                              text: 'ETB 1000',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: ColorConstant.primaryColor,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '/night',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: ColorConstant.inActiveColor),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            childCount: 1000,
          ),
        ),
      ],
    ));
  }
}
