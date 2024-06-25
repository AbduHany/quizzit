/*
Author: Abdelrahman Hany Metawei
Date: 22-06-2024
Description:
  This Flutter file contains the user's profile page which shows the user's
  profile picture, a settings icon, and various stats for the user.
*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzit/src/pages/home_page/home_page.dart';
import 'package:quizzit/src/pages/profile_page/edit_profile.dart';
import 'package:quizzit/src/services/data_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  Map<dynamic, dynamic> data = {};

  @override
  void initState() {
    super.initState();

    UserData.getData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  List<Map<String, String>> stats = [
    {"Games": "80"},
    {"Total Points": "1032"},
    {"Best Time": "13s"},
    {"Completion Rate": "81%"},
    {"Correct Answers": "72%"},
    {"Incorrect Answers": "28%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(height: MediaQuery.of(context).size.height * 0.10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Positioned(
                      right: 10,
                      child: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            // Edit Profile Page
                            PopupMenuItem(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          data: data,
                                        )));
                              },
                              child: const Text("Edit Profile"),
                            ),
                            // The Reset Stats Button
                            PopupMenuItem(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.09,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text("Are you sure?"),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        MaterialButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "No")),
                                                        MaterialButton(
                                                            // Adding the logic of resetting the Profile stats
                                                            onPressed: () {},
                                                            child: const Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ))
                                                      ])
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: const Text(
                                  "Reset stats",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ))
                          ];
                        },
                        icon: const Icon(Icons.settings),
                      )),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(30)),
                  height: MediaQuery.of(context).size.height * 0.63,
                  width: MediaQuery.of(context).size.width,
                ),
                //Profile Picture
                Positioned(
                  top: -75,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 5),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://scontent.fcai19-7.fna.fbcdn.net/v/t31.18172-8/15724857_533887406820970_2802802680928799024_o.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEC3I6worX_nrKstmzAadAD3vimT8yBya_e-KZPzIHJrw2zeNzDX3b6UzlJWOY9iCI&_nc_ohc=jfBXg1heusMQ7kNvgHu4uNP&_nc_ht=scontent.fcai19-7.fna&oh=00_AYDQ0KXb0-RVOkexTe9zAgNMFOAdGjSzWfTBOqzXUtdh2g&oe=669D7163"),
                            fit: BoxFit.cover)),
                    height: 200,
                    width: 200,
                    /* child: const Icon(
                      Icons.person_4_rounded,
                      size: 90,
                    ), */
                  ),
                ),
                // User's first and last name
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: Text(
                    "${data['firstName']} ${data['lastName']}",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                /* Stats boxes read from a Map defined above with each stat and value
                stats are being read from the variable stats declared above.
                */
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        children: List.generate(stats.length, (i) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  stats[i].values.first,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  stats[i].keys.first,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),

      // bottom navigation bar
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
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
