import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey = '';

Future sendTextCompletionRequest(String message) async {
  String baseUrl = 'https://api.openai.com/v1/chat/completions';
  Map<String, String> headers = {
    'Content-Type': 'Application/json; charset=UTF-8',
    'Authorization': 'Bearer $apiKey',
  };
  var res = await http.post(
    Uri.parse(baseUrl),
    headers: headers,
    body: json.encode(
      {
        'model': 'gtp-3.5-turbo', //'text-davinci-003',
        'messages': [
          {"role": "user", "content": message}
        ],
        //'prompt': message,
        // 'temperature': 0,
        // 'max_token': 2000,
        // 'top_p': 1,
        // 'n': 1,
        // 'frecuency_penalty': 0.0,
        // 'presence_penalty': 0.0,
        // 'streams': false,
        // 'logprobs': null,
      },
    ),
  );
  if (res.statusCode == 200) {
    final resultBody = utf8.decode(res.bodyBytes);
    final String result =
        jsonDecode(resultBody)['choices'][0]['message']['content'];
    return result.trim();
  }
}
