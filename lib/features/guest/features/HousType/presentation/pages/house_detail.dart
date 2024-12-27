import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

class HouseDetail extends StatelessWidget {
  const HouseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(
          route: "houseTypeDetail",
        ),
      ),
      body: Column(
        spacing: 10,
        children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselView(
                      itemExtent: MediaQuery.of(context).size.width,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: Image.network(
                                "https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 25,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.black
                                                .withValues(alpha: 0.4),
                                          ),
                                          child: Row(
                                            children: List.generate(
                                                3,
                                                (index) => Container(
                                                      width: 7,
                                                      height: 7,
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white),
                                                    )),
                                          ))
                                    ]))
                          ],
                        )
                      ])),
              ListTile(
                  title: SecctionHeader(
                      title: 'Stylish Guest House', isSeeMore: false),
                  subtitle: SeeMoreText(
                    text:
                        'Lorem ipsum dolor sit amet consectetur. Purus elit susp endisse massa turpis et amet. Dignissim diam vel odio risus .Lorem ipsum dolor sit amet consectetur. Purus elit suspe ndisse massa turpis et amet. Dignissim   Readmore.',
                    maxLines: 4,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 19,
                    ),
                    Text(
                      "Addis Ababa, Ayat",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 10,
                  children: [
                    CircleAvatar(),
                    Text(
                      "Posted by Yonas",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Card(
                color: ColorConstant.cardGrey.withValues(alpha: 0.5),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    "Available facilities",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      runSpacing: 15,
                      spacing: 30,
                      children: List.generate(
                        10,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstant.yellow),
                                child: Icon(
                                  Icons.wifi,
                                  color: Colors.white,
                                )),
                            Text("wifi")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 15,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      "200 ETB",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text("/per day")
                  ],
                ),
                Expanded(
                    child: CustomButton(
                        onPressed: () {
                          context.goNamed('booking');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: EdgeInsets.all(20),
                        ),
                        child: Text(
                          "Book",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  const SeeMoreText({Key? key, required this.text, this.maxLines = 4})
      : super(key: key);

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          softWrap: true,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'See More' : 'See Less',
            style: textTheme.bodyMedium?.copyWith(
              color: ColorConstant.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
