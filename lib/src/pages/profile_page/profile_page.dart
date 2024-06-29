/*
Author: Abdelrahman Hany Metawei
Date: 22-06-2024
Description:
  This Flutter file contains the user's profile page which shows the user's
  profile picture, a settings icon, and various stats for the user.
*/
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzit/src/pages/home_page/home_page.dart';
import 'package:quizzit/src/pages/profile_page/edit_profile.dart';
import 'package:quizzit/src/services/data_services.dart';
import 'package:quizzit/src/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  Map<dynamic, dynamic> data = {};
  Map<dynamic, dynamic> statsMap = {};
  List<Map<dynamic, dynamic>> statsList = [];

  @override
  void initState() {
    super.initState();
    UserData.getData().then((value) {
      setState(() {
        data = value;
      });
    });
    StatsData.getData().then((value) {
      statsMap = value;
      int startedQuiz = statsMap["StartedQuiz"];
      int completedQuiz = statsMap["CompletedQuiz"];
      int correctAnswers = statsMap["CorrectAnswers"];
      int wrongAnswers = statsMap["WrongAnswers"];
      int totalAnswers = correctAnswers + wrongAnswers;
      setState(() {
        statsList = [
          {"Quiz Started": startedQuiz.toString()},
          {"Quiz Completed": completedQuiz.toString()},
          {"Total Points": "${correctAnswers * 10}"},
          {
            "Completion Rate":
                "${startedQuiz == 0 ? 0 : ((completedQuiz / startedQuiz) * 100).toStringAsFixed(0)}%"
          },
          {
            "Correct Answers":
                "${totalAnswers == 0 ? 0 : (correctAnswers / totalAnswers * 100).toStringAsFixed(0)}%"
          },
          {
            "Incorrect Answers":
                "${totalAnswers == 0 ? 0 : (wrongAnswers / totalAnswers * 100).toStringAsFixed(0)}%"
          },
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do you want to exit Quizzit?"),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("No")),
                              MaterialButton(
                                  // Adding the logic of resetting the Profile stats
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ])
                      ],
                    ),
                  ),
                );
              },
            ) ??
            false;
        if (context.mounted && shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height * 0.10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "Profile",
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Positioned(
                        right: 10,
                        child: PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              // Edit Profile Page
                              PopupMenuItem(
                                onTap: () async {
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => EditProfile(
                                                data: data,
                                              )));
                                  Map newData = await UserData.getData();
                                  setState(() {
                                    data = newData;
                                  });
                                },
                                child: const Text("Edit Profile"),
                              ),
                              // The Reset Stats Button
                              PopupMenuItem(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              content: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text("Are you sure?"),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          MaterialButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "No")),
                                                          MaterialButton(
                                                              // Adding the logic of resetting the Profile stats
                                                              onPressed: () {
                                                                resetStats()
                                                                    .then(
                                                                  (value) {
                                                                    setState(
                                                                        () {
                                                                      statsList =
                                                                          value;
                                                                    });
                                                                  },
                                                                );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Yes",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)))
                                                        ])
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: const Text(
                                    "Reset stats",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ];
                          },
                          icon: const Icon(Icons.settings),
                        )),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width,
                  ),
                  //Profile Picture
                  Positioned(
                    top: MediaQuery.of(context).size.height * -0.1,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 5),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.height * .2,
                      child: Icon(
                        Icons.person_4_rounded,
                        size: MediaQuery.of(context).size.height * .1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // User's first and last name
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    child: Text(
                      "${data['firstName']} ${data['lastName']}",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  /* Stats boxes read from a Map defined above with each stat and value
                  stats are being read from the variable stats declared above.
                  */
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.20,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          children: List.generate(statsList.length, (i) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    statsList[i].values.first,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    statsList[i].keys.first,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),

        // bottom navigation bar
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                iconSize: 30,
                color: Colors.grey[900],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
                iconSize: 30,
                color: Colors.grey[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Map<String, String>>> resetStats() async {
  String statFile = (await getApplicationDocumentsDirectory()).path + statData;
  File(statFile).writeAsStringSync(jsonEncode({
    "StartedQuiz": 0,
    "CompletedQuiz": 0,
    "CorrectAnswers": 0,
    "WrongAnswers": 0
  }));
  return [
    {"Quiz Started": "0"},
    {"Quiz Completed": "0"},
    {"Total Points": "0"},
    {"Completion Rate": "0%"},
    {"Correct Answers": "0%"},
    {"Incorrect Answers": "0%"},
  ];
}
