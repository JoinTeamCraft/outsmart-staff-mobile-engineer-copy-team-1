import 'dart:convert';

import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/features/lessons/data/models/lesson_model.dart';

class LessonRepository {
  LessonRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<Lesson>> getLessons() async {
    try {
      final rawData = await _apiClient.getLessonsRaw();
      final decoded = jsonDecode(rawData);

      if (decoded is! List) {
        return <Lesson>[];
      }

      return decoded
          .map((entry) => Lesson.fromJson(Map<String, dynamic>.from(entry as Map)))
          .toList();
    } catch (_) {
      return <Lesson>[];
    }
  }
}
