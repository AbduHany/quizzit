/* 
Author: Abdelrahman Hany Metawei
Date: 22-06-2024
Description:
  This Flutter file defines the Widget that appears before the user starts a
  where they are prompted for the difficulty of the quiz they want to take.
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiffSelection extends StatelessWidget {
  final List<String> categories;
  final int categoryIndex;

  const DiffSelection(
      {super.key, required this.categories, required this.categoryIndex});

  @override
  Widget build(BuildContext context) {
    late String? chosenDifficulty;
    late String? chosenCategory;
    return AlertDialog(
      alignment: Alignment.center,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.19,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select difficulty: ",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 5,
            ),
            DropdownMenu(
              initialSelection: "Easy",
              onSelected: (val) {
                chosenCategory = categories[categoryIndex];
                chosenDifficulty = val!;
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: "Easy", label: "Easy 😊"),
                DropdownMenuEntry(value: "Medium", label: "Medium 🥲"),
                DropdownMenuEntry(value: "Hard", label: "Hard 😭"),
                DropdownMenuEntry(value: "Random", label: "Random 🤪")
              ],
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            const SizedBox(
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
                  borderRadius: BorderRadius.circular(10)),
              minWidth: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                //just a test for category and diff
                print(chosenCategory);
                print(chosenDifficulty);
              },
              child: Text(
                "Start Quiz!",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
