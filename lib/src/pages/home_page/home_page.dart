/* 
Author: Abdelrahman Hany Metawei
Date: 18-06-2024
Description:
  This Flutter file contains the Home Page the user sees after clicking on the
  "start playing" button in the start page where the user will have access to a
  list of categories and a strike card that shows how much points the user has.
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzit/src/pages/home_page/strike_card.dart';
import 'package:quizzit/src/pages/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> categories = [
      "History",
      "Geography",
      "Sports",
      "Star Wars",
      "Animals",
      "Science",
      "Languages",
      "Pokemon"
    ];

    String chosenDifficulty = "Easy";
    String chosenCategory = categories[0];

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          // Top part with Welcome, User
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListTile(
              title: Text(
                "Welcome back, User",
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
          StrikeCard(),
          // The categories of the quizez
          Container(
            margin: const EdgeInsets.only(top: 50, left: 20),
            child: Text(
              "categories",
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
                    child: MaterialButton(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:
                                const BorderSide(width: 1, color: Colors.grey)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.center,
                                  content: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.19,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select difficulty: ",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        DropdownMenu(
                                          initialSelection: "Easy",
                                          onSelected: (val) {
                                            setState(() {
                                              chosenCategory =
                                                  categories[index];
                                              chosenDifficulty = val!;
                                            });
                                          },
                                          dropdownMenuEntries: const [
                                            DropdownMenuEntry(
                                                value: "Easy",
                                                label: "Easy 😊"),
                                            DropdownMenuEntry(
                                                value: "Medium",
                                                label: "Medium 🥲"),
                                            DropdownMenuEntry(
                                                value: "Hard",
                                                label: "Hard 😭"),
                                            DropdownMenuEntry(
                                                value: "Random",
                                                label: "Random 🤪")
                                          ],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        /*
                                        START QUIZ BUTTON:
                                          Category of quiz is stored in chosenCategory &
                                          Difficulty of quiz is stored in chosenDifficulty
                                          variables
                                        */
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          onPressed: () {
                                            //just a test for category and diff
                                            print(chosenCategory);
                                            print(chosenDifficulty);
                                          },
                                          child: Text(
                                            "Start Quiz!",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 80,
                              width: 100,
                              child: const Icon(
                                Icons.question_mark,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              categories[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ProfilePage()));
              },
              icon: const Icon(Icons.person),
              iconSize: 30,
              color: Colors.grey[900],
            ),
          ],
        ),
      ),
    );
  }
}
