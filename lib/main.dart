import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './presentation/screens/code_review_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'DevLens',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const CodeReviewScreen(),
      ),
    );
  }
}
