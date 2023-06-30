import 'package:http/http.dart' as http;

class GlobalHandler{
  Future<http.Response> requestGet(String url) async{
    Uri parsedURL = Uri.parse(url);
    return http.get(parsedURL);
  }
}

var globalHandler = GlobalHandler();