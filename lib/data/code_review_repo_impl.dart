import 'package:dio/dio.dart';
import '../domain/repositories/code_review_repo.dart';

class CodeReviewRepoImpl implements CodeReviewRepo {
  final Dio dio = Dio();

  @override
  Future<String> getCodeReview(String code) async {
    try {
      final response = await dio.post(
        "https://devlens-nzkh.onrender.com/api/review",
        data: {"code": code},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["review"];
      } else {
        return "## ❌ Error\nUnexpected response";
      }
    } catch (e) {
      return "## ❌ Error\n${e.toString()}";
    }
  }
}
