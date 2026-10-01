import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistryBotService {
  RegistryBotService({
    http.Client? client,
    String? endpoint,
    String? apiKey,
    String? model,
  })  : _client = client ?? http.Client(),
        _endpoint = endpoint ?? const String.fromEnvironment(
          'REGISTRY_BOT_ENDPOINT',
          defaultValue: 'https://openrouter.ai/api/v1/chat/completions',
        ),
        _apiKey = apiKey ?? const String.fromEnvironment('REGISTRY_BOT_API_KEY'),
        _model = model ?? const String.fromEnvironment('REGISTRY_BOT_MODEL');

  final http.Client _client;
  final String _endpoint;
  final String _apiKey;
  final String _model;

  Future<String> ask(String question) async {
    if (_apiKey.isEmpty || _model.isEmpty) {
      throw StateError(
        'API 설정이 없습니다. REGISTRY_BOT_API_KEY와 REGISTRY_BOT_MODEL을 '
        '--dart-define으로 설정하세요.',
      );
    }

    final response = await _client.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + _apiKey,
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {
            'role': 'system',
            'content': '당신은 대한민국 부동산 등기절차 안내 도우미입니다. '
                '일반적인 절차 정보를 한국어로 안내하고 확실하지 않은 사항은 확인이 필요하다고 명시하세요.',
          },
          {'role': 'user', 'content': question},
        ],
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API 오류 ' + response.statusCode.toString());
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = json['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw const FormatException('API 응답에 choices가 없습니다.');
    }
    final message = (choices.first as Map<String, dynamic>)['message'];
    final content = message is Map<String, dynamic> ? message['content'] : null;
    if (content is String && content.trim().isNotEmpty) return content.trim();
    throw const FormatException('API 응답에서 답변을 찾지 못했습니다.');
  }

  void dispose() => _client.close();
}
