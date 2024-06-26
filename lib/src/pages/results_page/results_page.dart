/*
Author: Abdelrahman Hany Metawei
Date: 21-06-2024
Description:
  This Flutter file contains the results page that the user views after finishing
  a quiz where they can view how well they performed in a quiz (their completion
  percentage, correct & wrong answers, and the amound of questions).
*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzit/src/pages/home_page/home_page.dart';
import 'package:quizzit/src/pages/quiz_page/quiz_page.dart';
import 'package:quizzit/src/pages/results_page/score_stack.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.quizQuestions,
    required this.correctCount,
    required this.wrongCount,
  });
  final List<dynamic> quizQuestions;
  final double correctCount;
  final double wrongCount;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, Icon>> bottomIcons = [
      {"Replay": const Icon(Icons.replay)},
      {"Home": const Icon(Icons.home)},
      {"Share": const Icon(Icons.share)}
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Column(
          children: [
            ScoreStack(
                quizQuestions: widget.quizQuestions,
                correctCount: widget.correctCount,
                wrongCount: widget.wrongCount),
            // bottom panel with the icons
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    bottomIcons.length,
                    (index) => Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            iconSize: 30,
                            onPressed: () {
                              switch (bottomIcons[index].keys.first) {
                                case "Replay":
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => QuizPage(
                                              category: "",
                                              difficulty: "",
                                              quizQuestions:
                                                  widget.quizQuestions)),
                                      (route) => false);
                                  break;
                                case "Home":
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                      (route) => false);
                                  break;
                                case "Share":
                                  Share.share(
                                      "I scored ${(widget.correctCount * 100).toInt()}%, check out quizzit App");
                                  print("share");
                                  break;
                                default:
                              }
                            },
                            icon: bottomIcons[index].values.first,
                          ),
                        ),
                        Text(bottomIcons[index].keys.first,
                            style: GoogleFonts.poppins())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
