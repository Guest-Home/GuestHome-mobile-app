import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/color/color.dart';
import 'package:path/path.dart' as path;

class ProfilePhotoCard extends StatefulWidget {
  const ProfilePhotoCard({super.key, required this.image, required this.ontap});

  final XFile? image;
  final VoidCallback ontap;

  @override
  State<ProfilePhotoCard> createState() => _ProfilePhotoCardState();
}

class _ProfilePhotoCardState extends State<ProfilePhotoCard> {
  String size = '';

  Future<void> getImageSIze() async {
    // Convert XFile to File
    final file = File(widget.image!.path);
    // Get the file size in bytes
    final int sizeInBytes = await file.length();
    // Convert bytes to megabytes
    final double sizeInMB = sizeInBytes / (1024 * 1024);
    size = sizeInMB.toStringAsFixed(2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getImageSIze();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image!.path.isEmpty) {
      return const Center(child: Text(''));
    }
    return Card(
      elevation: 0.2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorConstant.cardGrey)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: FileImage(File(widget.image!.path)),
              radius: 50,
              backgroundColor: ColorConstant.cardGrey,
            ),
            Expanded(
              child: Stack(children: [
                ListTile(
                  title: Text(
                    widget.image!.name.substring(0, 10) +
                        path.extension(widget.image!.path),
                    maxLines: 1,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text("$size MB",
                          style: Theme.of(context).textTheme.bodyMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 5,
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              color: ColorConstant.red,
                              minHeight: 6,
                              backgroundColor: ColorConstant.primaryColor,
                              value: 1,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorConstant.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Text("100%"),
                         SizedBox(width: 16,)
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child:  GestureDetector(
                    onTap: widget.ontap,
                    child: Icon(
                      Icons.delete,
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
