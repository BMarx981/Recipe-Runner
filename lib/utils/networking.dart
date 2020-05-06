import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
//  String appID = '&app_id=46657ddc';
//  String apiKey = '&app_key=b79ed60a105bf4679f7c603966fb3e44';
//  String url = 'https://api.edamam.com/search?q=';
  String url = 'https://api.spoonacular.com/recipes/search?query=';
  String instructionsURL = 'https://api.spoonacular.com/recipes/';
  String apiKey = '&apiKey=53bf403cf96d411383884c0cf6ef50c5';
  String count = '&number=2';
  String reqInstr = '&instructionsRequired=true';
  //https://api.edamam.com/search?q=lunch&app_id={MYID}&app_key=${MYKEY}

  Future<Map<String, dynamic>> getRequest(String query) async {
    //String apiCall = '$url$query$appID$apiKey';
    String apiCall = '$url$query$apiKey$count$reqInstr';
    http.Response response = await http.get(apiCall);
    if (response.statusCode >= 200) {
//      print(response.body);
      return json.decode(response.body);
    }
//    return null;
  }

  Future<List<dynamic>> getInstructions(String id) async {
    String apiCall =
        '$instructionsURL$id/analyzedInstructions?stepBreakdown=true$apiKey';
    http.Response response = await http.get(apiCall);
    if (response.statusCode >= 200) {
      return json.decode(response.body);
    }
  }
}
