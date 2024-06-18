import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  top: 50,
                  child: Text(
                    "Great Work!",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 130,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.white,
                    ),
                    height: 250,
                    width: 250,
                    child: ListTile(
                      title: Text(
                        "Your Score",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                      subtitle: Text(
                        "80%",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 400,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary)),
                    height: 200,
                    width: 300,
                    child: GridView.count(
                      childAspectRatio: 1.5,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          child: ListTile(
                            title: Text(
                              "100%",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("completion",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                )),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          child: ListTile(
                            title: Text(
                              "20",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("questions",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                )),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          child: ListTile(
                            title: Text(
                              "13",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("correct",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                )),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          child: ListTile(
                            title: Text(
                              "07",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("wrong",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.replay),
                        ),
                      ),
                      Text("Replay", style: GoogleFonts.poppins())
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.home),
                        ),
                      ),
                      Text("Home", style: GoogleFonts.poppins())
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.remove_red_eye),
                        ),
                      ),
                      Text("Preview", style: GoogleFonts.poppins())
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                        ),
                      ),
                      Text("Share", style: GoogleFonts.poppins())
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
