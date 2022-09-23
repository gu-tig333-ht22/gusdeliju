//import 'dart:js';
import 'package:flutter/material.dart';
import 'AddItemView.dart';
import 'package:provider/provider.dart';
import 'checkbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

//const API_KEY = '4332f801-310e-4e3e-88c3-d179d6fdfba4';
//const API_URL = 'https://todoapp-api.apps.k8s.gu.se/todos?key=';

class Api {
  static Future<List<Items>> addItems(Items items) async {
    Map<String, dynamic> json = items.toJson();
    var bodyString = jsonEncode(json);
    var response = await http.post(
      'https://todoapp-api.apps.k8s.gu.se/todos?key=4332f801-310e-4e3e-88c3-d179d6fdfba4',
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<Items>((data) {
      return Items.fromJson(data);
    }).toList();
  }
}
