import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocConsumer<OnBordingBloc, OnBordingState>(
                  buildWhen: (previous, current) =>
                      previous.index != current.index,
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Expanded(
                          child: PageView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: pageController,
                            children: [
                              LanguageSelection(),
                              OnbordScreen(
                                title: "Book a room anytime anywhere",
                                subtitle:
                                    "",
                                image: "assets/icons/on1.png",
                              ),
                              OnbordScreen(
                                title:
                                    "Manage your property easily",
                                subtitle:
                                    "",
                                image: "assets/icons/on2.png",
                              ),
                              OnbordScreen(
                                title:
                                    "Post your home and go viral",
                                subtitle:
                                    "",
                                image: "assets/icons/on3.png",
                              ),

                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top:1),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                              title: state.index == 0
                                  ? Text("")
                                  : Row(
                                spacing: 5,
                                      children: List.generate(
                                        4,
                                        (index) => AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          width: index == state.index ? 24 : 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              color: index == state.index
                                                  ? ColorConstant.primaryColor
                                                  : ColorConstant.inActiveColor.withValues(
                                                alpha: 0.2
                                              ),
                                              borderRadius: BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                              subtitle: state.index == 0
                                  ? Text("")
                                  : GestureDetector(
                                onTap: () =>  context
                                    .read<OnBordingBloc>()
                                    .add(OnBordingGetStartedEvent()),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, top: 15),
                                        child: Text("Skip",
                                            style: TextStyle(
                                                color: ColorConstant.secondBtnColor,
                                                fontSize: 16)),
                                      ),
                                  ),
                              trailing: GestureDetector(
                                onTap: () {
                                  if (state.index == 3) {
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
                                      backgroundColor: ColorConstant.primaryColor,
                                      radius: 26,
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),

                      ].animate().fade(),
                    );
                  },
                  listener: (context, state) async {
                    if (state is GetStartedState) {
                      context.goNamed("houseType");
                    } else {
                      pageController.jumpToPage(state.index);
                    }
                  },
                ))),
    );
  }
}
