import 'dart:convert';
import 'package:http/http.dart' as http;

class AiCaptionService {
  Future<String> fetchAiCaption() async {
    await Future.delayed(const Duration(seconds: 2));

    final response = await http.get(Uri.parse('https://dummyjson.com/quotes'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final quotes = data['quotes'] as List<dynamic>;
      return quotes.isNotEmpty ? quotes.first['quote'] : 'Stay positive ✨';
    } else {
      throw Exception('Failed to generate caption');
    }
  }
}
