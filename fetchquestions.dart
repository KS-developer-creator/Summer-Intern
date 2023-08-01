import 'package:http/http.dart' as http;
import 'dart:convert';
import 'createpoll.dart';
import 'DatabaseHelper.dart';
import 'login.dart';
import 'main.dart';
Future<List<dynamic>> fetchQuestions() async {
  var url = 'https://pollkaro.com/API_'; // Replace with your API endpoint URL

  try {
    final response = await http.get(Uri.parse(url+"/api.php"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final questions = jsonData['questions'];
      return questions != null ? List.from(questions) : []; // Assuming the API response contains a 'questions' field with an array of questions
    } else {
      throw Exception('Failed to fetch questions');
    }
  } catch (error) {
    throw Exception('API request error: $error');
  }
}
