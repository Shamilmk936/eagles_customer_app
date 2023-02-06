class Question {
  final String question;
  final List<Answer> answersList;

  Question(this.question, this.answersList);
}

class Answer {
  final String Myanswer;
  final bool isCorrect;
//hhhhh
  Answer(this.Myanswer, this.isCorrect);
}

List<Question> getQuestion() {
  List<Question> list = [];

  list.add(Question("The first alpha version of Flutter was released in?", [
    Answer("2017", true),
    Answer("2018", false),
    Answer("2020", false),
    Answer("2019", false),
  ]));

  list.add(Question(
      "A widget that allows us to refresh the screen is called a ___________ ",
      [
        Answer("Stateless widgets", false),
        Answer("Statebuild widget", false),
        Answer("Stateful", true),
        Answer("All of the above", false),
      ]));

  list.add(Question("Flutter is not a language it is an SDK.", [
    Answer("True", true),
    Answer("False", false),
    Answer("Can not say", false),
    Answer("Can be True or False", false),
  ]));

  list.add(Question("Flutter is not a language it is an SDK.", [
    Answer("True", true),
    Answer("False", false),
    Answer("Can not say", false),
    Answer("Can be True or False", false),
  ]));

  list.add(Question("Flutter is not a language it is an SDK.", [
    Answer("True", true),
    Answer("False", false),
    Answer("Can not say", false),
    Answer("Can be True or False", false),
  ]));
  return list;
}
