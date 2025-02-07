import 'package:shared_preferences/shared_preferences.dart';

class GetToken {
  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('access'); // Replace with your key
    return authToken??"";
  }
}
