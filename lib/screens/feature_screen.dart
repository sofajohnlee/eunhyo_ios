import 'package:flutter/material.dart';
import '../models/app_feature.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key, required this.feature});
  final AppFeature feature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(feature.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(feature.emoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: 20),
              Text(feature.title,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(
                'Android 원본의 ' + feature.title + ' 기능을 이 화면으로 단계적으로 이전합니다.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
