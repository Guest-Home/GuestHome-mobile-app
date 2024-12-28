import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';
import '../widgets/language_selection.dart';
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
    return BlocListener<OnBordingBloc, OnBordingState>(
      listener: (context, state) {
        if (state is GetStartedState) {
          context.goNamed('properties');
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstant.primaryColor,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: BlocConsumer<OnBordingBloc, OnBordingState>(
                  buildWhen: (previous, current) =>
                      previous.index != current.index,
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: IndexedStack(
                          index: state.index,
                          sizing: StackFit.expand,
                          children: [
                            LanguageSelection(),
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
                        )),
                        ListTile(
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
                              padding:
                                  const EdgeInsets.only(right: 20, top: 15),
                              child: Text("Skip",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                context.setLocale(Locale('om', 'ET'));
                                if (state.index == 4) {
                                  context
                                      .read<OnBordingBloc>()
                                      .add(OnBordingGetStartedEvent());
                                } else {
                                  context
                                      .read<OnBordingBloc>()
                                      .add(OnBordingChangeEvent());
                                }
                              },
                              child: CustomPaint(
                                painter:
                                    ProgressPainter(progress: state.progress),
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
                            )),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  },
                  listener: (context, state) {
                    if (state is GetStartedState) {
                      context.goNamed("accountSetup");
                    }
                  },
                ))),
      ),
    );
  }
}
