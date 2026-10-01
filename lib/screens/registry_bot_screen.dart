import 'package:flutter/material.dart';
import '../services/registry_bot_service.dart';

class RegistryBotScreen extends StatefulWidget {
  const RegistryBotScreen({super.key});

  @override
  State<RegistryBotScreen> createState() => _RegistryBotScreenState();
}

class _RegistryBotScreenState extends State<RegistryBotScreen> {
  final _controller = TextEditingController();
  final _service = RegistryBotService();
  String _answer = '';
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    _service.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final question = _controller.text.trim();
    if (question.isEmpty || _loading) return;
    setState(() {
      _loading = true;
      _answer = '';
    });
    try {
      final answer = await _service.ask(question);
      if (mounted) setState(() => _answer = answer);
    } catch (e) {
      if (mounted) setState(() => _answer = '오류가 발생했습니다.\n' + e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('등기절차안내봇')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('등기 절차에 대해 질문해 주세요.',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    minLines: 2,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: '예: 소유권이전등기는 어떻게 하나요?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _loading ? null : _ask,
                      icon: _loading
                          ? const SizedBox(width: 18, height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.send),
                      label: Text(_loading ? '답변 생성 중...' : '질문하기'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_answer.isNotEmpty)
                    Expanded(
                      child: Card(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(18),
                          child: SelectableText(_answer,
                              style: const TextStyle(fontSize: 16, height: 1.5)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
