import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/features/lessons/data/repositories/lesson_repository.dart';
import 'package:streaklearn/features/quiz/data/repositories/quiz_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LessonRepository', () {
    test('returns typed lessons from mock data', () async {
      final repository = LessonRepository(apiClient: ApiClient());

      final lessons = await repository.getLessons();

      expect(lessons, hasLength(3));
      expect(lessons.first.title, 'Flutter Basics & Widgets');
      expect(lessons.first.topic, 'Fundamentals');
    });
  });

  group('QuizRepository', () {
    test('returns a quiz for a matching lesson id', () async {
      final repository = QuizRepository(apiClient: ApiClient());

      final quiz = await repository.getQuizByLessonId('lesson-1');

      expect(quiz, isNotNull);
      expect(quiz!.lessonId, 'lesson-1');
      expect(quiz.questions, hasLength(2));
      expect(quiz.questions.first.question, contains('Flutter UI'));
    });

    test('returns null on simulated network failure', () async {
      final apiClient = ApiClient();
      apiClient.simulateNetworkFailure = true;
      final repository = QuizRepository(apiClient: apiClient);

      final quiz = await repository.getQuizByLessonId('lesson-1');

      expect(quiz, isNull);
    });
  });
}
