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
import 'package:quizzit/src/pages/results_page/score_stack.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, Icon>> bottom_icons = [
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
            ScoreStack(),
            // bottom panel with the icons
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    bottom_icons.length,
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
                            onPressed: () {},
                            icon: bottom_icons[index].values.first,
                          ),
                        ),
                        Text(bottom_icons[index].keys.first,
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
