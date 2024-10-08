import 'dart:convert';
import 'dart:developer';

import 'package:avani/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    const String tag = 'post_chat_completion';

    var url = Uri.parse('https://api.openai.com/v1/chat/completions');
    log('$tag GET URL: $url');

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $openAIAPIKEY',
    };
    log('$tag header: $header');

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content":
              "Does this message want to generate an AI picture, image, art or anything similar? $prompt Simply answer with yes or no."
        }
      ],
    };
    log('$tag body: $body');

    try {
      final response = await http.post(url, headers: header, body: json.encode(body));
      log('$tag response: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final result = decodedResponse['choices'][0]['message']['content'];
        final content = result.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final output = await dallEAPI(prompt);
            return output;
          default:
            final output = await chatGPTAPI(prompt);
            return output;
        }
      }

      return 'An internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });

    const String tag = 'post_chat_completion';

    var url = Uri.parse('https://api.openai.com/v1/chat/completions');
    log('$tag GET URL: $url');

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $openAIAPIKEY',
    };
    log('$tag header: $header');

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": messages,
    };
    log('$tag body: $body');

    try {
      final response = await http.post(url, headers: header, body: json.encode(body));
      log('$tag response: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final result = decodedResponse['choices'][0]['message']['content'];
        final content = result.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }

      return 'An internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });

    const String tag = 'post_image_generation';

    var url = Uri.parse('https://api.openai.com/v1/images/generations');
    log('$tag GET URL: $url');

    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $openAIAPIKEY',
    };
    log('$tag header: $header');

    Map<String, dynamic> body = {
      "model": "dall-e-3",
      "prompt": prompt,
      "n": 1,
    };
    log('$tag body: $body');

    try {
      final response = await http.post(url, headers: header, body: json.encode(body));
      log('$tag response: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final imageUrl = decodedResponse['data'][0]['url'];
        final content = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }

      return 'An internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }
}
