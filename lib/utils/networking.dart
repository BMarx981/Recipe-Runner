import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  String appID = '&app_id=46657ddc';
  String apiKey = '&app_key=b79ed60a105bf4679f7c603966fb3e44';
  String url = 'https://api.edamam.com/search?q=';
  //https://api.edamam.com/search?q=lunch&app_id={MYID}&app_key=${MYKEY}

  Future<Map<String, dynamic>> getRequest(String query) async {
    String apiCall = '$url$query$appID$apiKey';
    http.Response response = await http.get(apiCall);
    if (response.statusCode >= 200) {
      return json.decode(response.body);
    }
  }
}
