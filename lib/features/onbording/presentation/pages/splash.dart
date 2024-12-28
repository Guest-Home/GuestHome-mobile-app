
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/home.png'),
            Text("MinApp",style: Theme.of(context).textTheme.headlineLarge,)
          ],
        ),),
      ),
    );
  }
}
