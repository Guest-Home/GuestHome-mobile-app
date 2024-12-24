import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 27,
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          'Language',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Language*"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "English",
                      filled: true,
                      fillColor: ColorConstant.cardGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {},
                        color: Colors.white,
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                value: "English", child: Text("English")),
                            PopupMenuItem(value: "አማርኛ", child: Text("አማርኛ")),
                            PopupMenuItem(
                                value: "Afan Oromo", child: Text("Afan Oromo")),
                          ];
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
