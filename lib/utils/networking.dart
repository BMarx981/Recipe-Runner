import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  String local = 'http://localhost:8081/?q=';

  Future<Map<String, dynamic>> getRequest(String query) async {
    String apiCall = '$local$query';
    http.Response response = await http.get(apiCall);
    if (response.statusCode == 200 && response.statusCode < 300) {
      return json.decode(Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
