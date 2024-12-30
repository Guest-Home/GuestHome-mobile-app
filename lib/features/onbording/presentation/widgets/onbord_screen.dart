import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnbordScreen extends StatelessWidget {
  const OnbordScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: ListTile(
            title: Text(title,
                style: TextTheme.of(context)
                    .headlineSmall
                    ?.copyWith(color: Colors.white)
                //TextStyle(fontSize: 25,color: Colors.white),
                ),
            subtitle: Column(
              spacing: 10,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 16, color: Colors.white.withValues(alpha: 0.6)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: SvgPicture.asset(
                        image,
                        semanticsLabel: 'language',
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
