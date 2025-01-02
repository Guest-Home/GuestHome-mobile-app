import 'package:image_picker/image_picker.dart';

class FilePicker {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> picImage() async {
    // make it with isolates
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image;
  }
}
