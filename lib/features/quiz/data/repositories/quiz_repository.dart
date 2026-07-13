import 'dart:convert';

import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/features/quiz/data/models/quiz_model.dart';

class QuizRepository {
  QuizRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<Quiz?> getQuizByLessonId(String lessonId) async {
    try {
      final rawData = await _apiClient.getQuizzesRaw();
      final decoded = jsonDecode(rawData);

      if (decoded is! List) {
        return null;
      }

      final quizPayload = decoded.cast<Map<dynamic, dynamic>>().firstWhere(
        (entry) => (entry['lessonId'] as String?) == lessonId,
        orElse: () => <dynamic, dynamic>{},
      );

      if (quizPayload.isEmpty) {
        return null;
      }

      return Quiz.fromJson(Map<String, dynamic>.from(quizPayload));
    } catch (_) {
      return null;
    }
  }
}
