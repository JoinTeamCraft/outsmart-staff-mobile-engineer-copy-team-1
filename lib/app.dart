import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/di/service_locator.dart';
import 'core/state/lesson_state.dart';
import 'core/state/quiz_state.dart';
import 'core/state/streak_state.dart';

class StreakLearnApp extends StatelessWidget {
  const StreakLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LessonState>.value(value: locator<LessonState>()),
        ChangeNotifierProvider<QuizState>.value(value: locator<QuizState>()),
        ChangeNotifierProvider<StreakState>.value(value: locator<StreakState>()),
      ],
      child: MaterialApp(
        title: 'StreakLearn',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreenPlaceholder(),
        },
      ),
    );
  }
}

class HomeScreenPlaceholder extends StatelessWidget {
  const HomeScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonState = context.watch<LessonState>();
    final quizState = context.watch<QuizState>();
    final streakState = context.watch<StreakState>();

    return Scaffold(
      appBar: AppBar(title: const Text('StreakLearn State Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.school, size: 64, color: Colors.deepPurple),
                const SizedBox(height: 16),
                Text(
                  lessonState.currentLessonTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lesson ID: ${lessonState.currentLessonId.isEmpty ? "none" : lessonState.currentLessonId}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text('Quiz answered: ${quizState.answeredCount}'),
                Text('Selected answer: ${quizState.selectedAnswerIndex}'),
                Text('Quiz lesson: ${quizState.activeLessonId.isEmpty ? "none" : quizState.activeLessonId}'),
                const SizedBox(height: 8),
                Text('Current streak: ${streakState.currentStreak}'),
                Text('Best streak: ${streakState.bestStreak}'),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        lessonState.selectLesson(
                          lessonId: 'lesson-101',
                          lessonTitle: 'Intro to Momentum',
                        );
                      },
                      child: const Text('Set Lesson'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        quizState.startQuizForLesson('lesson-101');
                        quizState.selectAnswer(1);
                      },
                      child: const Text('Answer Quiz'),
                    ),
                    ElevatedButton(
                      onPressed: streakState.increment,
                      child: const Text('Add Streak'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        lessonState.selectLesson(
                          lessonId: '',
                          lessonTitle: 'No lesson selected',
                        );
                        quizState.resetQuiz();
                        streakState.reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
