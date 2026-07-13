import 'package:flutter/foundation.dart';

/// UI-facing lesson state.
///
/// Keep repository models out of widgets by translating incoming data into
/// simple values that screens can read and modify through methods here.
class LessonState extends ChangeNotifier {
  LessonState({
    String currentLessonId = '',
    String currentLessonTitle = 'No lesson selected',
    bool isLoading = false,
  })  : _currentLessonId = currentLessonId,
        _currentLessonTitle = currentLessonTitle,
        _isLoading = isLoading;

  String _currentLessonId;
  String _currentLessonTitle;
  bool _isLoading;

  String get currentLessonId => _currentLessonId;
  String get currentLessonTitle => _currentLessonTitle;
  bool get isLoading => _isLoading;

  void selectLesson({
    required String lessonId,
    required String lessonTitle,
  }) {
    _currentLessonId = lessonId;
    _currentLessonTitle = lessonTitle;
    notifyListeners();
  }

  void setLoading(bool value) {
    if (_isLoading == value) {
      return;
    }
    _isLoading = value;
    notifyListeners();
  }
}
