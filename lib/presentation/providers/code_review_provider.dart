import './code_review_state.dart';
import '../../domain/models/language.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/code_review_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/code_review_repo.dart';

final codeReviewRepo = Provider<CodeReviewRepo>((ref) {
  return CodeReviewRepoImpl();
});

final codeReviewProvider =
    StateNotifierProvider<CodeReviewNotifier, CodeReviewState>((ref) {
      final codeRepo = ref.watch(codeReviewRepo);
      return CodeReviewNotifier(codeRepo);
    });

class CodeReviewNotifier extends StateNotifier<CodeReviewState> {
  final CodeReviewRepo codeRepo;

  CodeReviewNotifier(this.codeRepo) : super(CodeReviewState.initial());

  Future<void> getAIReview(String code, Language lang) async {
    state = state.copyWith(
      isLoading: true,
      reviewResult: "### 🤖 AI is analyzing your ${lang.label} code...",
    );

    final data = await codeRepo.getCodeReview(code);

    state = state.copyWith(reviewResult: data, isLoading: false);
  }

  void changeLanguage(Language lang) {
    state = state.copyWith(selectedLanguage: lang);
  }

  void updateReview(String msg) {
    state = state.copyWith(reviewResult: msg);
  }
}
