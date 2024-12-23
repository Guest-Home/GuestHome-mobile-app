import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';
import '../widgets/onbord_screen.dart';
import '../widgets/progress_painter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<OnBordingBloc, OnBordingState>(
                buildWhen: (previous, current) =>
                    previous.index != current.index,
                builder: (context, state) {
                  return IndexedStack(
                    index: state.index,
                    sizing: StackFit.expand,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          spacing: 40,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/language.svg",
                                  semanticsLabel: 'language',
                                  width: 20,
                                  height: 20,
                                ),
                                Text(
                                  "Select Language",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                                spacing: 10,
                                children: List.generate(
                                  3,
                                  (index) => Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          shape: BoxShape.rectangle,
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: RadioListTile.adaptive(
                                        value: true,
                                        activeColor: Colors.white,
                                        selected: index.isEven ? true : false,
                                        title: Text(
                                          state.language[index],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        groupValue: true,
                                        onChanged: (value) {},
                                      )),
                                )),
                          ],
                        ),
                      ),
                      OnbordScreen(
                        title: "Lorem ipsum dolor sit amet consectetur.",
                        subtitle:
                            "Lorem ipsum dolor sit amet consectetur. Est sed ridiculus nisl massa.",
                        image: "assets/icons/onbord-image-1.svg",
                      ),
                      OnbordScreen(
                        title: "Lorem ipsum dolor sit amet consectetur.",
                        subtitle:
                            "Lorem ipsum dolor sit amet consectetur. Est sed ridiculus nisl massa.",
                        image: "assets/icons/onbord-image-1.svg",
                      ),
                      OnbordScreen(
                        title: "Lorem ipsum dolor sit amet consectetur.",
                        subtitle:
                            "Lorem ipsum dolor sit amet consectetur. Est sed ridiculus nisl massa.",
                        image: "assets/icons/onbord-image-1.svg",
                      ),
                      OnbordScreen(
                        title: "Lorem ipsum dolor sit amet consectetur.",
                        subtitle:
                            "Lorem ipsum dolor sit amet consectetur. Est sed ridiculus nisl massa.",
                        image: "assets/icons/onbord-image-2.svg",
                      ),
                    ],
                  );
                },
              ),
            ),
            BlocBuilder<OnBordingBloc, OnBordingState>(
              buildWhen: (previous, current) => previous.index != current.index,
              builder: (context, state) {
                return ListTile(
                    title: Row(
                      children: List.generate(
                        5,
                        (index) => AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: index == state.index ? 30 : 8,
                          height: 8,
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              color: index == state.index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 15),
                      child: Text("Skip",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        context
                            .read<OnBordingBloc>()
                            .add(onbordingChangeEvent(index: state.index + 1));
                        //  pageController.jumpToPage(state.index);
                      },
                      child: CustomPaint(
                        painter: ProgressPainter(progress: state.progress),
                        child: Container(
                          width: 67,
                          height: 67,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 25,
                              color: ColorConstant.secondBtnColor,
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      )),
    );
  }
}
