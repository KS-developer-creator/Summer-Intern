import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'main.dart';
import 'createpoll.dart';
import 'fetchquestions.dart';

import 'main.dart';

class Poll {
  final String id;
  final String question;
  final List<String> options;

  Poll({required this.id, required this.question, required this.options});

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }
}
Future<List<dynamic>> fetchPolls() async {
  var url = 'https://pollkaro.com/API_';
  var uri = Uri.parse(url + "/api.php");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Poll.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch polls');
  }
}
