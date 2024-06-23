import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreStack extends StatefulWidget {
  const ScoreStack({super.key});

  @override
  State<ScoreStack> createState() => _ScoreStackState();
}

class _ScoreStackState extends State<ScoreStack> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, int>> scoreElems = [
      {"completion": 100},
      {"questions": 20},
      {"correct": 13},
      {"wrong": 7},
    ];
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.primary,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "Great Work!",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
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
          top: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 2, color: Theme.of(context).colorScheme.primary)),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.7,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: scoreElems.length,
              itemBuilder: (context, i) {
                return Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  child: ListTile(
                    title: Text(
                      scoreElems[i].values.first.toString().padLeft(2, '0'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(scoreElems[i].keys.first,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        )),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
