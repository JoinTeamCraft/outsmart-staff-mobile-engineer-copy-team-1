import 'package:get_it/get_it.dart';
import '../../features/lessons/data/repositories/lesson_repository.dart';
import '../../features/quiz/data/repositories/quiz_repository.dart';
import '../network/api_client.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerLazySingleton<LessonRepository>(() => LessonRepository());
  locator.registerLazySingleton<QuizRepository>(() => QuizRepository());
}