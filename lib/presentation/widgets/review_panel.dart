import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/code_review_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class ReviewPanel extends ConsumerWidget {
  const ReviewPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final reviewResult = ref.watch(
              codeReviewProvider.select((s) => s.reviewResult),
            );

            return Container(
              color: const Color(0xFF161616),
              padding: const EdgeInsets.all(16),
              child: reviewResult.isEmpty
                  ? const Center(
                      child: Text(
                        "AI Review will appear here...",
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  : Markdown(
                      data: reviewResult,
                      selectable: true,
                      styleSheet: MarkdownStyleSheet(
                        h2: const TextStyle(color: Colors.blueAccent),
                        code: const TextStyle(
                          backgroundColor: Colors.black,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
            );
          },
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  ref
                      .read(codeReviewProvider.notifier)
                      .updateReview(
                        "### AI Review Results\nPaste your code and click Review.",
                      );
                },
                icon: Icon(Icons.clear, color: Colors.white),
              ),

              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: ref.read(codeReviewProvider).reviewResult,
                    ),
                  ).then((_) {
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied to clipboard')),
                    );
                  });
                },
                icon: Icon(Icons.copy, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
