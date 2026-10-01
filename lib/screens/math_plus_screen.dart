import 'dart:math';
import 'package:flutter/material.dart';

class MathPlusScreen extends StatefulWidget {
  const MathPlusScreen({super.key});

  @override
  State<MathPlusScreen> createState() => _MathPlusScreenState();
}

class _MathPlusScreenState extends State<MathPlusScreen> {
  final _random = Random();
  final _answerController = TextEditingController();
  int _left = 7;
  int _right = 5;
  int _score = 0;
  int _questions = 0;
  String _message = '문제를 풀어 보세요!';

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _newQuestion() {
    setState(() {
      _left = _random.nextInt(20) + 1;
      _right = _random.nextInt(20) + 1;
      _message = '문제를 풀어 보세요!';
      _answerController.clear();
    });
  }

  void _checkAnswer() {
    final answer = int.tryParse(_answerController.text.trim());
    if (answer == null) {
      setState(() => _message = '숫자를 입력해 주세요.');
      return;
    }
    final correct = answer == _left + _right;
    setState(() {
      _questions++;
      if (correct) {
        _score++;
        _message = '정답이에요! 잘했어요! 🎉';
      } else {
        _message = '아쉬워요. 정답은 ' + (_left + _right).toString() + '입니다.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('수학 · 덧셈')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('점수 ' + _score.toString() + ' / ' + _questions.toString(),
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 28),
                  Text(_left.toString() + ' + ' + _right.toString() + ' = ?',
                      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _answerController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: '정답',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _checkAnswer(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: _checkAnswer, child: const Text('정답 확인')),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _newQuestion, child: const Text('새 문제')),
                  const SizedBox(height: 24),
                  Text(_message, textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
