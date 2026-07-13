import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:streaklearn/app.dart';
import 'package:streaklearn/core/state/lesson_state.dart';
import 'package:streaklearn/core/state/quiz_state.dart';
import 'package:streaklearn/core/state/streak_state.dart';

void main() {
  group('state management', () {
    test('LessonState updates the selected lesson and loading flag', () {
      final state = LessonState();

      expect(state.currentLessonTitle, 'No lesson selected');
      expect(state.currentLessonId, isEmpty);
      expect(state.isLoading, isFalse);

      state.setLoading(true);
      expect(state.isLoading, isTrue);

      state.selectLesson(
        lessonId: 'lesson-1',
        lessonTitle: 'Flutter Basics & Widgets',
      );

      expect(state.currentLessonId, 'lesson-1');
      expect(state.currentLessonTitle, 'Flutter Basics & Widgets');
      expect(state.isLoading, isTrue);
    });

    test('QuizState tracks the active lesson and answer selection', () {
      final state = QuizState();

      expect(state.activeLessonId, isEmpty);
      expect(state.selectedAnswerIndex, -1);
      expect(state.answeredCount, 0);

      state.startQuizForLesson('lesson-1');
      state.selectAnswer(1);

      expect(state.activeLessonId, 'lesson-1');
      expect(state.selectedAnswerIndex, 1);
      expect(state.answeredCount, 1);

      state.resetQuiz();
      expect(state.selectedAnswerIndex, -1);
      expect(state.answeredCount, 0);
    });

    test('StreakState increments and resets values', () {
      final state = StreakState();

      state.increment();
      expect(state.currentStreak, 1);
      expect(state.bestStreak, 1);

      state.reset();
      expect(state.currentStreak, 0);
      expect(state.bestStreak, 1);
    });

    testWidgets('HomeScreenPlaceholder reflects state changes in the UI', (
      tester,
    ) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LessonState()),
            ChangeNotifierProvider(create: (_) => QuizState()),
            ChangeNotifierProvider(create: (_) => StreakState()),
          ],
          child: const MaterialApp(home: HomeScreenPlaceholder()),
        ),
      );

      expect(find.text('No lesson selected'), findsOneWidget);
      expect(find.textContaining('Lesson ID: none'), findsOneWidget);
      expect(find.textContaining('Current streak: 0'), findsOneWidget);

      await tester.tap(find.text('Set Lesson'));
      await tester.pump();

      expect(find.text('Intro to Momentum'), findsOneWidget);
      expect(find.textContaining('Lesson ID: lesson-101'), findsOneWidget);
    });
  });
}
