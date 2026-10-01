import 'package:flutter/material.dart';
import '../models/app_feature.dart';
import 'feature_screen.dart';
import 'math_plus_screen.dart';
import 'registry_bot_screen.dart';
import 'sports_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const features = <AppFeature>[
    AppFeature(title: '학교 공부', emoji: '🏫', description: '초등학교 학습', routeName: 'school'),
    AppFeature(title: '수학', emoji: '➕', description: '수학 문제 풀이', routeName: 'math'),
    AppFeature(title: '영어', emoji: '🔤', description: '영어 학습', routeName: 'english'),
    AppFeature(title: '국어·한자', emoji: '📚', description: '국어와 한자 학습', routeName: 'korean'),
    AppFeature(title: '그림 그리기', emoji: '🎨', description: '그림과 페인팅', routeName: 'drawing'),
    AppFeature(title: '게임', emoji: '🎮', description: '교육용 게임', routeName: 'games'),
    AppFeature(title: '스포츠', emoji: '🏸', description: '운동 영상', routeName: 'sports'),
    AppFeature(title: 'AI', emoji: '🤖', description: 'AI 학습 기능', routeName: 'ai'),
    AppFeature(title: '등기절차안내봇', emoji: '🏛️', description: '등기 절차 질문', routeName: 'registry'),
  ];

  void _openFeature(BuildContext context, AppFeature feature) {
    final Widget page;
    switch (feature.routeName) {
      case 'math':
        page = const MathPlusScreen();
        break;
      case 'sports':
        page = const SportsScreen();
        break;
      case 'registry':
        page = const RegistryBotScreen();
        break;
      default:
        page = FeatureScreen(feature: feature);
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('은효야, 칭찬해~~'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 900 ? 4 : constraints.maxWidth >= 600 ? 3 : 2;
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: features.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.18,
              ),
              itemBuilder: (context, index) {
                final feature = features[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _openFeature(context, feature),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(feature.emoji, style: const TextStyle(fontSize: 38)),
                          const SizedBox(height: 8),
                          Text(feature.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(feature.description, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
