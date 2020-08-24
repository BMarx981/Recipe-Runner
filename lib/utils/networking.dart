import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  String url = 'https://api.spoonacular.com/recipes/search?query=';
  String instructionsURL = 'https://api.spoonacular.com/recipes/';
  String apiKey = '&apiKey=53bf403cf96d411383884c0cf6ef50c5';
  String count = '&number=2';
  String reqInstr = '&instructionsRequired=true';

  Future<Map<String, dynamic>> getRequest(String query) async {
    String apiCall = '$url$query$apiKey$count$reqInstr';
    http.Response response = await http.get(apiCall);
//    http.Response response = await http.get('http://127.0.0.1:8080');
    if (response.statusCode >= 200 && response.statusCode < 300) {
//      debugPrint(Utf8Decoder().convert(response.bodyBytes), wrapWidth: 1000);
      return json.decode(Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }

  Future<List<dynamic>> getDirections(String id) async {
    String apiCall = '$instructionsURL$id/analyzedInstructions?$apiKey';
    http.Response response = await http.get(apiCall);
//    http.Response response = await http.get('http://127.0.0.1:8080/second');
    if (response.statusCode >= 200 && response.statusCode < 300) {
//      debugPrint(Utf8Decoder().convert(response.bodyBytes), wrapWidth: 1000);
      return json.decode(Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }

  Future<Map<String, dynamic>> getIngredients(String id) async {
    String apiCall = '$instructionsURL$id/ingredientWidget.json?$apiKey';
    http.Response response = await http.get(apiCall);
//    http.Response response = await http.get('http://127.0.0.1:8080/third');
    if (response.statusCode >= 200 && response.statusCode < 300) {
//      debugPrint(Utf8Decoder().convert(response.bodyBytes), wrapWidth: 1000);
      return json.decode(Utf8Decoder().convert(response.bodyBytes));
    }
    print('Problem with the response is ${response.statusCode}');
    return null;
  }
}

//http.Response response = await _api.getData();
//String source = Utf8Decoder().convert(response.bodyBytes);

//  String appID = '&app_id=46657ddc';
//  String apiKey = '&app_key=b79ed60a105bf4679f7c603966fb3e44';
//  String url = 'https://api.edamam.com/search?q=';
