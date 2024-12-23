import 'package:flutter/material.dart';
import '../../../../../../core/common/back_button.dart';

class AddProperties extends StatefulWidget {
  const AddProperties({super.key});

  @override
  State<AddProperties> createState() => _AddPropertiesState();
}

class _AddPropertiesState extends State<AddProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 34,
        leading: AppBarBackButton(
          route: "properties",
        ),
      ),
      body: Center(
        child: Text("add property"),
      ),
    );
  }
}
