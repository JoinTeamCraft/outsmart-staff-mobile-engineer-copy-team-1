class Question {
  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;

  factory Question.fromJson(Map<String, dynamic> json) {
    final optionsJson = json['options'];
    return Question(
      id: (json['id'] as String?) ?? '',
      question: (json['question'] as String?) ?? '',
      options: optionsJson is List
          ? optionsJson.map((option) => option.toString()).toList()
          : <String>[],
      correctIndex: (json['correctIndex'] as num?)?.toInt() ?? 0,
    );
  }
}

class Quiz {
  const Quiz({
    required this.lessonId,
    required this.questions,
  });

  final String lessonId;
  final List<Question> questions;

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final questionsJson = json['questions'];
    return Quiz(
      lessonId: (json['lessonId'] as String?) ?? '',
      questions: questionsJson is List
          ? questionsJson
              .map((entry) => Question.fromJson(Map<String, dynamic>.from(entry as Map)))
              .toList()
          : <Question>[],
    );
  }
}
