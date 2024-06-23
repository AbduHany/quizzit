import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String dateOfBirth = "03/08/1994";
  String firstName = "Darth";
  String lastName = "Vader";
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "Edit Profile",
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.of(context).size.height * 0.63,
                    width: MediaQuery.of(context).size.width),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.white),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  firstName = value;
                                });
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: firstName,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  fillColor: Colors.white,
                                  filled: true),
                            )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  lastName = value;
                                });
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: lastName,
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  fillColor: Colors.white,
                                  filled: true),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Date of Birth",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.white),
                        ),
                        const Divider(),
                        TextFormField(
                            onChanged: (value) {
                              setState(() {
                                dateOfBirth = value;
                              });
                            },
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                fillColor: Colors.white,
                                filled: true)),
                        const SizedBox(height: 30),
                        Text(
                          "Gender",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.white),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.black,
                                  ),
                                  title: Text("Male",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.white)),
                                  value: "Male",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: RadioListTile(
                                    fillColor: WidgetStateProperty.resolveWith(
                                      (states) => Colors.black,
                                    ),
                                    title: Text(
                                      "Female",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    value: "Female",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    }))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2,
                  vertical: MediaQuery.of(context).size.height * 0.04),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // New variables are saved in the firstName, lastName and gender
                onPressed: () {},
                color: Colors.red[800],
                child: Text(
                  "Save changes",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
