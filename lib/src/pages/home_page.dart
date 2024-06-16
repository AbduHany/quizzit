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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            toolbarHeight: 200,
            title: ListTile(
              title: Text(
                "Welcome back, User",
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                "Let's Play!",
                style: GoogleFonts.ubuntu(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
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
                elevation: 20,
                color: Colors.grey[900],
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
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "+ 10 daily points",
                                style: GoogleFonts.ubuntu(color: Colors.white),
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
                            child: const Icon(
                              Icons.star_rounded,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const LinearProgressIndicator(
                          value: 0.3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                "Categories",
                style: GoogleFonts.ubuntu(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
