import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:streaklearn/app.dart';
import 'package:streaklearn/core/state/lesson_state.dart';
import 'package:streaklearn/core/state/quiz_state.dart';
import 'package:streaklearn/core/state/streak_state.dart';

void main() {
  group('state management', () {
    test('LessonState loads lessons and updates the selected lesson', () async {
      final state = LessonState();

      await state.loadLessons();

      expect(state.lessonCount, 3);
      expect(state.selectedLessonTitle, 'Flutter Basics & Widgets');
      expect(state.isLoading, isFalse);
    });

    test('QuizState loads quiz details for a lesson', () async {
      final state = QuizState();

      await state.loadQuiz('lesson-1');

      expect(state.hasQuiz, isTrue);
      expect(state.questionCount, 2);
      expect(state.errorMessage, isNull);
    });

    test('StreakState increments and resets values', () {
      final state = StreakState();

      state.incrementStreak();
      expect(state.currentStreak, 1);
      expect(state.bestStreak, 1);

      state.resetStreak();
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

      await tester.tap(find.text('Load lessons'));
      await tester.pump();

      expect(find.textContaining('Lessons loaded:'), findsOneWidget);
      expect(find.textContaining('Streak:'), findsOneWidget);
    });
  });
}
