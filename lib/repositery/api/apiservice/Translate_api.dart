import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translater/repositery/model/translatemodel.dart';

class TranslateApi {

  Future<TranslateModel> getTranslate(String text, String code) async {

    // 🔹 Replace with your real API URL
    final String url = "https://google-translator9.p.rapidapi.com/v2";

    var body = {"q":text,"source":"en","target":code,"format":"text"};

    try {
      // ✅ Print request body
      print("Request Body: $body");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer YOUR_API_KEY", // if required
         "x-rapidapi-key":"b7fdb7d435msh89b1f37285d7ae0p12a1e3jsnb4c5a91a15ad",
         "x-rapidapi-host":"google-translator9.p.rapidapi.com"
        },
        body: jsonEncode(body),
      );

      // ✅ Print response
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return TranslateModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to translate: ${response.body}");
      }

    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
}