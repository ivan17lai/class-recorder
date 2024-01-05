import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

String encodeArray(List<List<String>> array) {
  return jsonEncode(array);
}

List<List<String>> decodeArray(String jsonString) {
  List<dynamic> decoded = jsonDecode(jsonString);
  return List<List<String>>.from(decoded.map((item) => List<String>.from(item)));
}

Future<void> saveTwoDimensionalArray(String key, List<List<String>> array) async {
  String jsonString = encodeArray(array);
  await saveData(key, jsonString);
}


Future<List<List<String>>?> readTwoDimensionalArray(String key) async {
  String? jsonString = await readData(key);
  if (jsonString != null) {
    return decodeArray(jsonString);
  }
  return null;
}

saveSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
}

Future<void> saveData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> readData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<void> removeData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
