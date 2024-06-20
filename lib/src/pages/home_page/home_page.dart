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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    List<String> Categories = [
      "History",
      "Geography",
      "Sports",
      "Star Wars",
      "Animals",
      "Science",
      "Languages",
      "Pokemon"
    ];

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
          // The Categories of the quizez
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Text(
              "Categories",
              style: GoogleFonts.poppins(fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: [
                ...List.generate(Categories.length, (index) {
                  return Container(
                    width: (ScreenWidth - 20) / 2,
                    height: (ScreenWidth - 20) / 2,
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 1, color: Colors.grey)),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
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
                              Categories[index],
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
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
              iconSize: 30,
              color: Colors.grey[900],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
              iconSize: 30,
              color: Colors.grey[900],
            ),
          ],
        ),
      ),
    );
  }
}
