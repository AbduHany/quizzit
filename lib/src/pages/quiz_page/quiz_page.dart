import 'package:flutter/material.dart';
import 'package:quizzit/src/pages/quiz_page/radio_button_item.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _QuizPageState extends State<QuizPage> {
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: MediaQuery.of(context).size.width * .05,
              left: MediaQuery.of(context).size.width * .05,
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.70,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * .1,
              left: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * 0.20,
              bottom: MediaQuery.of(context).size.height * 0.55,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.green,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * .1,
              left: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * 0.18,
              bottom: MediaQuery.of(context).size.height * 0.75,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.deepPurpleAccent,
                ),
                child: const CircleAvatar(
                  child: Icon(
                    Icons.alarm_sharp,
                    size: 36,
                  ),
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * .1,
              left: MediaQuery.of(context).size.width * .6,
              top: MediaQuery.of(context).size.height * 0.20,
              bottom: MediaQuery.of(context).size.height * 0.75,
              child: Container(
                color: Colors.yellow,
                child: const Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: 0.5,
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("05"),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * .6,
              left: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * 0.20,
              bottom: MediaQuery.of(context).size.height * 0.75,
              child: Container(
                color: Colors.yellow,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("05"),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: 0.5,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * .1,
              left: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * 0.25,
              bottom: MediaQuery.of(context).size.height * 0.55,
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      children: [
                        Center(child: Text("data")),
                        Expanded(
                            child:
                                Text("AAAAA AAAA AAAA AAA AAAA AAAA AAA AAAA"))
                      ],
                    ),
                  )),
            ),
            Positioned(
                right: MediaQuery.of(context).size.width * .1,
                left: MediaQuery.of(context).size.width * .1,
                top: MediaQuery.of(context).size.height * 0.48,
                bottom: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  color: Colors.amber[50],
                  child: Column(
                    children: <Widget>[
                      RadioButtonItem(
                        value: 'Option 1',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                      RadioButtonItem(
                        value: 'Option 2',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                      RadioButtonItem(
                        value: 'Option 3',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                      RadioButtonItem(
                        value: 'Option 4',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
