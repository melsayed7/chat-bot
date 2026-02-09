import 'dart:convert';
import 'package:chat_bot_app/core/constant/constant_app.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  Future<String> sendMessage(List<Map<String, dynamic>> message) async {
    final response = await http.post(
      Uri.parse(ConstantApp.url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"contents": message}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
     // print(data);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception(response.body);
    }
  }
}
