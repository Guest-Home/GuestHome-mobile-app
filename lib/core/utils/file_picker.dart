import 'package:image_picker/image_picker.dart';

class FilePicker {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> picImage() async {
    // make it with isolates
    final XFile? image = await picker.pickImage(source: ImageSource.gallery,requestFullMetadata: true);

    return image;
  }

  Future<List<XFile>?> picMultipleImage() async {
    final List<XFile> images = await picker.pickMultiImage(requestFullMetadata: true);
    return images;
  }
}
