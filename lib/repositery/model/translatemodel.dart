
class TranslateModel {
    Data? data;

    TranslateModel({this.data});

    TranslateModel.fromJson(Map<String, dynamic> json) {
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    List<Translations>? translations;

    Data({this.translations});

    Data.fromJson(Map<String, dynamic> json) {
        translations = json["translations"] == null ? null : (json["translations"] as List).map((e) => Translations.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(translations != null) {
            _data["translations"] = translations?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Translations {
    String? translatedText;

    Translations({this.translatedText});

    Translations.fromJson(Map<String, dynamic> json) {
        translatedText = json["translatedText"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["translatedText"] = translatedText;
        return _data;
    }
}