import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../config/color/color.dart';
import 'package:path/path.dart' as path;

class PropertyPhotoCard extends StatefulWidget {
  const PropertyPhotoCard({
    super.key,
    required this.image,
    required this.ontap,
  });
  final XFile? image;
  final VoidCallback ontap;

  @override
  State<PropertyPhotoCard> createState() => _PropertyPhotoCardState();
}

class _PropertyPhotoCardState extends State<PropertyPhotoCard> {
  String imageSize="";
  Future<void> getImageFileSize(XFile image) async {
    int sizeInBytes = await image.length();
    double sizeInMB = sizeInBytes / (1024 * 1024); // Convert bytes to MB
    setState(() {
      imageSize="${sizeInMB.toStringAsFixed(2)} MB";
    });
  }
  @override
  void initState() {
    super.initState();
    getImageFileSize(widget.image!);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(widget.image!.path),
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
                widget.image!.name.substring(0, 10) + path.extension(widget.image!.path),
                maxLines: 1,
              ),
              subtitle: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(imageSize, style: Theme.of(context).textTheme.bodyMedium),
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
                onTap: widget.ontap,
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
