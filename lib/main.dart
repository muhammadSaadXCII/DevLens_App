import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './presentation/screens/code_review_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'AI-Powered Code Reviewer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const CodeReviewScreen(),
      ),
    );
  }
}
