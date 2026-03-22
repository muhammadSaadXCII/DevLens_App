import '../../domain/models/language.dart';

class CodeReviewState {
  final String reviewResult;
  final bool isLoading;
  final Language selectedLanguage;

  CodeReviewState({
    required this.reviewResult,
    required this.isLoading,
    required this.selectedLanguage,
  });

  factory CodeReviewState.initial() {
    return CodeReviewState(
      reviewResult: "### AI Review Results\nPaste your code and click Review.",
      isLoading: false,
      selectedLanguage: kSupportedLanguages.first,
    );
  }

  CodeReviewState copyWith({
    String? reviewResult,
    bool? isLoading,
    Language? selectedLanguage,
  }) {
    return CodeReviewState(
      reviewResult: reviewResult ?? this.reviewResult,
      isLoading: isLoading ?? this.isLoading,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
