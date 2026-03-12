import 'dart:convert';
import 'package:http/http.dart';
import 'package:translater/repositery/api/apiservice/client.dart';
import 'package:translater/repositery/model/language.dart';

class LanguageApi {
  final ApiClient apiClient = ApiClient();

  Future<List<LanguageModel>> getLanguage() async {
  String trendingpath = 'support-languages';
  var body = {


  };
  Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

  return LanguageModel.listFromJson(jsonDecode(response.body));
}
}