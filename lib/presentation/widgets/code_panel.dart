import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodePanel extends StatelessWidget {
  final CodeController controller;

  const CodePanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white10),
        ),
      ),
      child: CodeTheme(
        data: CodeThemeData(styles: monokaiSublimeTheme),
        child: CodeField(
          controller: controller,
          textStyle: const TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 14,
          ),
          expands: true,
          lineNumberStyle: const LineNumberStyle(
            width: 45,
            textStyle: TextStyle(color: Colors.white24),
          ),
        ),
      ),
    );
  }
}