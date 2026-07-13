import 'package:get_it/get_it.dart';
import '../../features/lessons/data/repositories/lesson_repository.dart';
import '../../features/quiz/data/repositories/quiz_repository.dart';
import '../network/api_client.dart';
import '../state/lesson_state.dart';
import '../state/quiz_state.dart';
import '../state/streak_state.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerLazySingleton<LessonRepository>(() => LessonRepository());
  locator.registerLazySingleton<QuizRepository>(() => QuizRepository());
  locator.registerSingleton<LessonState>(LessonState());
  locator.registerSingleton<QuizState>(QuizState());
  locator.registerSingleton<StreakState>(StreakState());
}
