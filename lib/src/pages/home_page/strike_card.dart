/* 
Author: Abdelrahman Hany Metawei
Date: 19-06-2024
Description:
  This Flutter file contains the card widget that displays the days of strikes
  that the user used the app consecutively and the points that the user obtained
  for either completing a quiz or logging in once daily.
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StrikeCard extends StatefulWidget {
  const StrikeCard({super.key});
  @override
  State<StrikeCard> createState() => _StrikeCardState();
}

class _StrikeCardState extends State<StrikeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        color: Theme.of(context).colorScheme.primary,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    margin: const EdgeInsets.only(right: 10),
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  value: 0.3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
