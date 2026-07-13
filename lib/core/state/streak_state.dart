import 'package:flutter/foundation.dart';

/// UI-facing streak state.
///
/// Store the current streak as a simple number and evolve it through methods
/// so the rest of the app does not depend on repository or persistence types.
class StreakState extends ChangeNotifier {
  StreakState({
    int currentStreak = 0,
    int bestStreak = 0,
  })  : _currentStreak = currentStreak,
        _bestStreak = bestStreak;

  int _currentStreak;
  int _bestStreak;

  int get currentStreak => _currentStreak;
  int get bestStreak => _bestStreak;

  void increment() {
    _currentStreak += 1;
    if (_currentStreak > _bestStreak) {
      _bestStreak = _currentStreak;
    }
    notifyListeners();
  }

  void reset() {
    _currentStreak = 0;
    notifyListeners();
  }
}
