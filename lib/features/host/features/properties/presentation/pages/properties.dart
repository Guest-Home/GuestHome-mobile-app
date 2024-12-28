import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/property_card.dart';
import '../widgets/search_filed.dart';

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
                child: SearchField(
                  onTextChnage: (value) {},
                )),
          ),
        ),
        // SliverFillRemaining(
        //   fillOverscroll: false,
        //   hasScrollBody: false,
        //   child: Container(
        //     padding: const EdgeInsets.all(10),
        //     child:
        //         Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text(
        //         'Lorem ipsum dolor sit amet consectetur. Est netus commodo mattis lectus nam lacinia hac sapien.',
        //         textAlign: TextAlign.center,
        //         style: Theme.of(context).textTheme.bodyLarge!,
        //       ),
        //       Padding(
        //           padding: const EdgeInsets.all(20),
        //           child:
        // CustomButton(
        //             style: ElevatedButton.styleFrom(
        //                 backgroundColor: ColorConstant.primaryColor,
        //                 padding: EdgeInsets.all(20),
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(10))),
        //             onPressed: () => context.goNamed('addProperty'),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Icon(Icons.add, color: Colors.white),
        //                 Text(
        //                   'Add Property',
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .bodyMedium!
        //                       .copyWith(color: Colors.white),
        //                 )
        //               ],
        //             ),
        //           ))
        //     ]),
        //   ),
        // ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
                onTap: () => context.goNamed('propertyDetail'),
                child: PropertyCard()),
            childCount: 5,
          ),
        ),
      ],
    ));
  }
}
