/*
Author: Abdelrahman Hany Metawei
Date: 17-06-2024
Description:
  This Flutter file contains the start page of Quizzit that users view the very
  first time they open the app.
*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzit/src/pages/home_page/home_page.dart';
import 'package:rive/rive.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        centerTitle: true,
        title: ListTile(
          title: Text(
            textAlign: TextAlign.center,
            "QUIZZIT",
            style: GoogleFonts.ubuntu(
              fontSize: 70,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          subtitle: Text(
            textAlign: TextAlign.center,
            "Where every question is an adventure!",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.6,
              child: const RiveAnimation.asset('assets/logo.riv')),
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height * 0.05)),
            child: MaterialButton(
              height: MediaQuery.of(context).size.height * 0.07,
              minWidth: MediaQuery.of(context).size.width * 0.6,
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              child: Text("Start Playing!",
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
