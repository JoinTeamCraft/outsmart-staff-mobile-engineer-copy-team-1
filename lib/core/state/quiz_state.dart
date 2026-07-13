import 'package:flutter/foundation.dart';

/// UI-facing quiz state.
///
/// Widgets should read answer counts and selection info from this class, and
/// call the methods below instead of mutating fields directly.
class QuizState extends ChangeNotifier {
  QuizState({
    String activeLessonId = '',
    int selectedAnswerIndex = -1,
    int answeredCount = 0,
  })  : _activeLessonId = activeLessonId,
        _selectedAnswerIndex = selectedAnswerIndex,
        _answeredCount = answeredCount;

  String _activeLessonId;
  int _selectedAnswerIndex;
  int _answeredCount;

  String get activeLessonId => _activeLessonId;
  int get selectedAnswerIndex => _selectedAnswerIndex;
  int get answeredCount => _answeredCount;

  void startQuizForLesson(String lessonId) {
    if (lessonId.isEmpty) {
      return;
    }

    _activeLessonId = lessonId;
    _selectedAnswerIndex = -1;
    _answeredCount = 0;
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (index < 0 || _activeLessonId.isEmpty || _selectedAnswerIndex != -1) {
      return;
    }

    _selectedAnswerIndex = index;
    _answeredCount += 1;
    notifyListeners();
  }

  void resetQuiz() {
    _activeLessonId = '';
    _selectedAnswerIndex = -1;
    _answeredCount = 0;
    notifyListeners();
  }
}