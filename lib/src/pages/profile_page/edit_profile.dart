import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzit/src/utils/constants.dart';

class EditProfile extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  const EditProfile({super.key, required this.data});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String dateOfBirth = "";
  String? firstName = "";
  String? lastName = "";
  String? gender = "";

  @override
  void initState() {
    dateOfBirth = widget.data["birthDate"];
    firstName = widget.data["firstName"];
    lastName = widget.data["lastName"];
    gender = widget.data["gender"];
    super.initState();
  }

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
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Username",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        const Divider(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  initialValue: firstName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      firstName = value;
                                    });
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      fillColor: Colors.white,
                                      filled: true),
                                )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        initialValue: lastName,
                                        onChanged: (value) {
                                          setState(() {
                                            lastName = value;
                                          });
                                        },
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          fillColor: Colors.white,
                                          filled: true,
                                        )))
                              ],
                            )),
                        const SizedBox(height: 30),
                        Text("Date of Birth",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const Divider(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(dateOfBirth,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                  )),
                              MaterialButton(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        dateOfBirth =
                                            picked.toString().substring(0, 10);
                                      });
                                    }
                                  },
                                  color: Colors.white,
                                  elevation: 10,
                                  child: Text(
                                    "Change date",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: Colors.black),
                                  ))
                            ]),
                        const SizedBox(height: 30),
                        Text("Gender",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
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
                                          fontSize: 16, color: Colors.white)),
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
                                    title: Text("Female",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: Colors.white)),
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
                onPressed: () {
                  if (formKey.currentState!.validate().toString() == "true") {
                    () async {
                      String userFilePath =
                          (await getApplicationDocumentsDirectory()).path +
                              userData;
                      File(userFilePath).writeAsStringSync(jsonEncode({
                        "firstName": firstName,
                        "lastName": lastName,
                        "gender": gender,
                        "birthDate": dateOfBirth
                      }));
                    }();
                    Navigator.pop(context);
                  }
                },
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
