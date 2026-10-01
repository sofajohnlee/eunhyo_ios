import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  static const videos = <({String title, String id})>[
    (title: '줄넘기', id: 'vVctfW2OCyQ'),
    (title: '배드민턴', id: 'hFf6P-mXEG4'),
    (title: '탁구', id: 'XcVOUkNzhVg'),
  ];

  Future<void> _openVideo(BuildContext context, String id) async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=' + id);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('동영상을 열 수 없습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('스포츠')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: videos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final video = videos[index];
            return Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.play_arrow)),
                title: Text(video.title),
                subtitle: const Text('YouTube 동영상'),
                trailing: const Icon(Icons.open_in_new),
                onTap: () => _openVideo(context, video.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
