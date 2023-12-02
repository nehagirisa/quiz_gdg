
class Question {
 late String question;
  String image;
  List<String> options;
  String correctAnswerIndex;

  Question({
    required this.question,
    required this.image,
    required this.options,
    required this.correctAnswerIndex,
  });
}