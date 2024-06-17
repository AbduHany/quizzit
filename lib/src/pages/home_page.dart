import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            toolbarHeight: 150,
            title: ListTile(
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
            )),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3 Days Strike!",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "+ 10 daily points",
                                style: GoogleFonts.poppins(color: Colors.white),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.star_rounded,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const LinearProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                          value: 0.3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
        //Bottom naviagation bar
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
