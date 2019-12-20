import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import './../global/global.dart';

class ApiService {
  String api_url = API_SERVER;

  ApiService();

  Future login(data) async {
    // This example uses the Google Books API to search for books about http.
    var url = "${api_url}authentication/login.json?email=${data['email']}&password=${data['password']}";
    // Await the http get response, then decode the json-formatted responce.
    try {
      http.Response response = await http.post(url);
      Map data = convert.jsonDecode(response.body);
      return data;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future signUp(data) async {
    // This example uses the Google Books API to search for books about http.
    var url = "${api_url}authentication/sign_up.json?first_name=${data['first_name']}&last_name=${data['last_name']}&gender=${data['gender']}&email=${data['email']}&password=${data['password']}";
    // https://tasker.superwizer.com/tasker/authentication/sign_up.json?first_name=hamza&last_name=javed&email=hamza@lahore.pk&password=hamza123&gender=male
    // Await the http get response, then decode the json-formatted responce.
    try {
      http.Response response = await http.post(url);
      Map data = convert.jsonDecode(response.body);
      return data;
    } catch (e) {
      print('Error: $e');
    }
  }
}
