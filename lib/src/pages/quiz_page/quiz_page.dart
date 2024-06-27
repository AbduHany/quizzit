import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzit/src/pages/quiz_page/radio_button_item.dart';
import 'package:quizzit/src/pages/results_page/results_page.dart';
import 'package:quizzit/src/services/api_service.dart';
import 'package:quizzit/src/utils/constants.dart';
import 'package:rive/rive.dart';

class QuizPage extends StatefulWidget {
  const QuizPage(
      {super.key,
      required this.category,
      required this.difficulty,
      this.quizQuestions = const []});
  final String category;
  final String difficulty;
  final List<dynamic> quizQuestions;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> qa = [];
  int currentIndex = 0;
  String? _selectedValue;
  List<String> _shuffledAnswers = [];
  String wrongCountText = "0";
  double wrongCount = 0;
  String correctCountText = "0";
  double correctCount = 0;

  Map<String, dynamic> stats = {};
  String statFile = "";

  @override
  void initState() {
    super.initState();
    fetchQuizQuestions();

    () async {
      statFile = (await getApplicationDocumentsDirectory()).path + statData;
      if (File(statFile).existsSync()) {
        // check if stat file exists
        String contents = await File(statFile).readAsString();
        Map<String, dynamic> statsFromFile = jsonDecode(contents);
        stats = statsFromFile;
        stats['StartedQuiz'] += 1;
        File(statFile).writeAsStringSync(jsonEncode(stats));
      }
    }();
  }

  Future<void> fetchQuizQuestions() async {
    if (widget.quizQuestions.isNotEmpty) {
      qa = widget.quizQuestions;
    } else {
      qa =
          await QuizzitAPi.getQuizQuestions(widget.category, widget.difficulty);
    }
    if (qa.isNotEmpty) {
      _shuffleAnswers();
    }
    setState(() {});
  }

  void _shuffleAnswers() {
    if (currentIndex < qa.length) {
      List<String> answers =
          List<String>.from(qa[currentIndex]["incorrect_answers"]);
      answers.add(qa[currentIndex]["correct_answer"]);
      answers.shuffle();
      _shuffledAnswers = answers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: qa.isNotEmpty && currentIndex < qa.length
            ? currentQuestion(currentIndex)
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget currentQuestion(int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          right: MediaQuery.of(context).size.width * .05,
          left: MediaQuery.of(context).size.width * .05,
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.55,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: Colors.grey,
                border: Border.all(color: Colors.white, width: 1)),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.18,
          bottom: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              // color: Colors.deepPurpleAccent,
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.alarm_sharp,
                size: 36,
              ),
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .6,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.75,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    value: wrongCount,
                    color: Colors.red,
                    backgroundColor: Colors.red[100],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  wrongCountText,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .6,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.75,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  correctCountText,
                  style: TextStyle(
                      color: Colors.green[700], fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    value: correctCount,
                    backgroundColor: Colors.green[200],
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.25,
          bottom: MediaQuery.of(context).size.height * 0.55,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              // color: Colors.deepPurpleAccent,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 1),
                      child: Center(
                          child: Text("Question ${currentIndex + 1}/10"))),
                  Expanded(
                      child: Text(
                    qa[currentIndex]["question"],
                    softWrap: true,
                    // overflow: TextOverflow.clip,
                    maxLines: 5,

                    style: const TextStyle(fontSize: 20),
                  )),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * .1,
          left: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0.48,
          bottom: MediaQuery.of(context).size.height * 0.05,
          child: Column(
            children: <Widget>[
              ..._shuffledAnswers
                  .map(
                    (element) => RadioButtonItem(
                      value: element,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        // print(qa[currentIndex]["correct_answer"]);
                        setState(() {
                          _selectedValue = value;
                          show = true;
                          if (qa[currentIndex]["correct_answer"] == value) {
                            crt = true;
                            correctCount += 0.1;
                            correctCountText =
                                '0${((correctCount * 10).ceil()).toString()}';
                            stats['CorrectAnswers'] += 1;
                            File(statFile).writeAsStringSync(jsonEncode(stats));
                          } else {
                            crt = false;
                            wrongCount += 0.1;
                            wrongCountText =
                                '0${((wrongCount * 10).ceil()).toString()}';
                            stats['WrongAnswers'] += 1;
                            File(statFile).writeAsStringSync(jsonEncode(stats));
                          }
                        });
                        Future.delayed(const Duration(milliseconds: 1500))
                            .then((_) {
                          setState(() {
                            show = false;
                            currentIndex += 1;
                            _selectedValue = null; // Reset the selected value
                            if (currentIndex < qa.length) {
                              _shuffleAnswers();
                            } else {
                              stats['CompletedQuiz'] += 1;
                              File(statFile)
                                  .writeAsStringSync(jsonEncode(stats));
                              // Handle end of questions
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                        quizQuestions: qa,
                                        correctCount: correctCount,
                                        wrongCount: wrongCount,
                                      )));
                              // currentIndex = 0;
                              // _shuffleAnswers();
                            }
                          });
                        });
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        answered()
      ],
    );
  }

  bool crt = false;
  bool show = false;
  Widget answered() {
    return show
        ? crt
            ? const Positioned(
                child: RiveAnimation.asset(
                'assets/right_animation.riv',
              ))
            : const Positioned(
                child: RiveAnimation.asset(
                'assets/wrong_animation.riv',
              ))
        : const SizedBox(
            height: 0.01,
            width: 0.01,
          );
  }
}
