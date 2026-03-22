import '../widgets/code_panel.dart';
import '../widgets/review_panel.dart';
import 'package:flutter/material.dart';
import '../widgets/language_dropdown.dart';
import '../../domain/models/language.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:highlight/languages/all.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:highlight/highlight_core.dart';
import '../providers/code_review_provider.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeReviewScreen extends ConsumerStatefulWidget {
  const CodeReviewScreen({super.key});

  @override
  ConsumerState<CodeReviewScreen> createState() => _CodeReviewScreenState();
}

class _CodeReviewScreenState extends ConsumerState<CodeReviewScreen> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    final language = ref.read(languageProvider);
    _codeController = CodeController(
      text: "",
      language: language,
      modifiers: [IndentModifier(), CloseBlockModifier(), TabModifier()],
    );
  }

  final languageProvider = StateProvider<Mode?>((ref) {
    final selectedLang = ref.watch(
      codeReviewProvider.select((s) => s.selectedLanguage),
    );
    return allLanguages[selectedLang.key];
  });

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onLanguageChanged(Language lang) {
    ref.read(codeReviewProvider.notifier).changeLanguage(lang);
    ref.read(languageProvider.notifier).state = allLanguages[lang.key];
    _codeController.language = allLanguages[lang.key];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black,
        titleSpacing: 16,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/images/dev_lens_logo.svg",
              width: 38,
              height: 38,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: const Text(
                "DevLens",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final selectedLanguage = ref.watch(
                codeReviewProvider.select((s) => s.selectedLanguage),
              );
              return LanguageDropdown(
                selected: selectedLanguage,
                onChanged: _onLanguageChanged,
              );
            },
          ),
          const SizedBox(width: 8),
          Consumer(
            builder: (context, ref, child) {
              final isLoading = ref.watch(
                codeReviewProvider.select((s) => s.isLoading),
              );
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    disabledBackgroundColor: Colors.blueGrey,
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(codeReviewProvider.notifier)
                              .getAIReview(
                                _codeController.text,
                                ref.read(codeReviewProvider).selectedLanguage,
                              );
                        },
                  icon: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text(
                    "Review",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          return Flex(
            direction: isWide ? Axis.horizontal : Axis.vertical,
            children: [
              Expanded(child: CodePanel(controller: _codeController)),
              Expanded(child: ReviewPanel()),
            ],
          );
        },
      ),
    );
  }
}
