import 'package:eagles_customer_app/userApp/screens/mcq/question&ans.dart';
import 'package:flutter/material.dart';

class MCQ extends StatefulWidget {
  const MCQ({Key? key}) : super(key: key);

  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  List<Question> questionList = getQuestion();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.cyan,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'MCQ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              _questions(),
              _answers(),
              _nextButton()
            ],
          ),
        ),
      ),
    );
  }

  _questions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question${currentQuestionIndex + 1}/${questionList.length.toString()}',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.orangeAccent),
          child: Text(questionList[currentQuestionIndex].question,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        )
      ],
    );
  }

  _answers() {
    return Column(
        children: questionList[currentQuestionIndex]
            .answersList
            .map((e) => _answerButton(e))
            .toList());
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 9),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              if (selectedAnswer == null) {
                if (answer.isCorrect) {
                  score++;
                }
              }
              setState(() {
                selectedAnswer = answer;
              });
            },
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: isSelected ? Colors.orangeAccent : Colors.white,
                onPrimary: isSelected ? Colors.white : Colors.black),
            child: Text(answer.Myanswer)));
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }
    return Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ElevatedButton(
            onPressed: () {
              if (isLastQuestion) {
                showDialog(
                  context: context,
                  builder: (context) => _showDialogue(),
                );
              } else {
                setState(() {});
                selectedAnswer = null;
                currentQuestionIndex++;
              }
            },
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Colors.blueAccent,
                onPrimary: Colors.white),
            child: Text(isLastQuestion ? "Submit" : "Next")));
  }

  _showDialogue() {
    bool isPassed = false;
    if (score > questionList.length * 0.5) {
      isPassed = true;
    }
    String title = isPassed ? "Congrats" : "Sorry ";
    return AlertDialog(
      title: Text(title + "your score is $score"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                selectedAnswer = null;
              });
            },
            child: Text('Restart'))
      ],
    );
  }
}
