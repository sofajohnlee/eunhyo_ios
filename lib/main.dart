import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EunhyoApp());
}

class EunhyoApp extends StatelessWidget {
  const EunhyoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '은효야, 칭찬해~~',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFFF9FC),
        cardTheme: const CardThemeData(elevation: 2, margin: EdgeInsets.zero),
      ),
      home: const HomeScreen(),
    );
  }
}
