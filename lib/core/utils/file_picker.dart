import 'dart:isolate';

import 'package:image_picker/image_picker.dart';

class FilePicker {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> picImage() async {
    // make it with isolates
    final XFile? image = await Isolate.run(
      () async {
        return await picker.pickImage(source: ImageSource.camera);
      },
    );
    return image;
  }
}
