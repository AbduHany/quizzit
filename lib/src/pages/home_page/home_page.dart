/* 
Author: Abdelrahman Hany Metawei
Date: 18-06-2024
Description:
  This Flutter file contains the Home Page the user sees after clicking on the
  "start playing" button in the start page where the user will have access to a
  list of categories and a strike card that shows how much points the user has.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzit/src/pages/home_page/diff_selection.dart';
import 'package:quizzit/src/pages/home_page/strike_card.dart';
import 'package:quizzit/src/pages/profile_page/profile_page.dart';
import 'package:quizzit/src/services/api_service.dart';
import 'package:quizzit/src/services/data_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  List categories = [];
  List questions = [];
  /*
  Film Icon Attribution: Film icons created by BZZRINCANTATION - Flaticon
  Geography Icon Attribution: Geography icons created by Freepik - Flaticon
  History Icon Attribution: History icons created by Freepik - Flaticon
  Sports Icon Attribution: Sports icons created by Freepik - Flaticon
  General Knowledge Icon Attribution: General Knowledge icons created by Freepik - Flaticon
  */
  Map icons = {
    'Geography': 'assets/icons/globe.png',
    'History': 'assets/icons/history.png',
    'Sports': 'assets/icons/sports.png',
    'General Knowledge': 'assets/icons/knowledge.png',
    'Entertainment: Film': 'assets/icons/film.png',
  };

  @override
  void initState() {
    super.initState();

    // get user name from the userData.json file
    UserData.getName().then((value) {
      setState(() {
        userName = value;
      });
    });
    QuizzitAPi.localQuizData().then((value) {
      // save all quiz questions in variable
      questions = value;
      setState(() {
        // get all unique categories in variable
        Set categoriesSet = questions.map((item) => item["category"]).toSet();
        // convert set to list
        categories = categoriesSet.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                    height: MediaQuery.of(context).size.height * 0.09,
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
        body: ListView(
          shrinkWrap: true,
          children: [
            // Top part with Welcome, User
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListTile(
                title: Text(
                  "Hello, $userName",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  "Let's Play!",
                  style: GoogleFonts.poppins(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            // The Card keeping track of consecutive logins for the user
            const StrikeCard(),
            // The categories of the quizez
            Container(
              margin: const EdgeInsets.only(top: 50, left: 20),
              child: Text(
                "Categories",
                style: GoogleFonts.poppins(fontSize: 25),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                children: [
                  ...List.generate(categories.length, (index) {
                    return Container(
                      width: (screenWidth - 20) / 2,
                      height: (screenWidth - 20) / 2,
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 10,
                        child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DiffSelection(
                                        categories: categories,
                                        categoryIndex: index);
                                  });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image.asset(icons[categories[index]]!),
                                ),
                                Text(
                                  categories[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )),
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
        // Bottom naviagation bar with the icons
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
                iconSize: 30,
                color: Colors.grey[900],
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                      (route) => false);
                },
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
