
import 'package:flutter/material.dart';

class Commission extends StatelessWidget {
  const Commission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: AppBarBackButton(),
        title: Text(
          'Platform Commission',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
