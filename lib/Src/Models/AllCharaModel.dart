import 'dart:convert';
List<String> charactersFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));
String charactersToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));