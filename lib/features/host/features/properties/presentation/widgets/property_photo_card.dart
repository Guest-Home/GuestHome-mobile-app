import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../config/color/color.dart';
import 'package:path/path.dart' as path;

class PropertyPhotoCard extends StatelessWidget {
  const PropertyPhotoCard({
    super.key,
    required this.image,
    required this.ontap,
  });
  final XFile? image;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(image!.path),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Stack(
          children: [
            ListTile(
              title: Text(
                image!.name.substring(0, 10) + path.extension(image!.path),
                maxLines: 1,
              ),
              subtitle: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("", style: Theme.of(context).textTheme.bodyMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 5,
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          color: ColorConstant.red,
                          backgroundColor: ColorConstant.primaryColor,
                          value: 1,
                          minHeight: 5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstant.primaryColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Text("100%"),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: GestureDetector(
                onTap: ontap,
                child: Icon(
                  Icons.delete_outlined,
                  size: 20,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Icon(
                Icons.check_circle,
                color: ColorConstant.primaryColor,
              ),
            )
          ],
        )),
      ],
    );
  }
}
