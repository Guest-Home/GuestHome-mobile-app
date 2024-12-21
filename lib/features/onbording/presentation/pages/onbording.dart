
import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';

import '../widgets/progress_painter.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> with SingleTickerProviderStateMixin {
  double _progress = 0.0;

  void _incrementProgress() {
    setState(() {
      _progress += 0.2;
      if (_progress > 1.0) _progress = 0.0; // Reset progress after completion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            Expanded(child: PageView()),
            ListTile(
              title:Row(children:List.generate(4,(index) => Container(
                width:index==0?30:10,
                height: 10,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
              ),),),
              subtitle: Text("Skip",style: TextStyle(color: Colors.white)),
              trailing: GestureDetector(
                onTap: _incrementProgress,
                child: CustomPaint(
                  painter: ProgressPainter(progress: _progress),
                  child: Container(
                    width: 75,
                    height: 75,
                    alignment: Alignment.center,
                    child:CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 25,
                        color: ColorConstant.secondBtnColor,
                      ),
                    ),
                  ),
                ),
              )

            )
          ],
        ),
      ),
    );
  }
}

