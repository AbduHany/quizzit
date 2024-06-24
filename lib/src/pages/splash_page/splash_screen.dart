import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzit/src/pages/start_page.dart';
import 'package:quizzit/src/services/api_service.dart';
import 'package:quizzit/src/services/data_services.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isloading = true;
  String loadingText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Expanded(
            child: Center(
              child: RiveAnimation.asset(
                'assets/quizzit_animation.riv',
              ),
            ),
          ),
          Visibility(
              child: Row(
            children: [
              CircularProgressIndicator(
                value: isloading ? null : 0,
              ),
              Expanded(child: Center(child: Text(loadingText)))
            ],
          ))
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    startUp();
    // Future.delayed(
    //     const Duration(seconds: 5),
    //     () => {
    //           Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(builder: (context) => const StartPage()),
    //               (Route<dynamic> route) => false)
    //         });
  }

  void startUp() {
    loadingText = "Loading";

    /* Creates the userData.json file and randomizes the names for the very
    first time the app is run.
    */
    UserData.firstTime();
    QuizzitAPi.status().then((onValue) {
      if (onValue.statusCode == 200) {
        if (kDebugMode) print("service is online");
        setState(() {
          loadingText = "service is online";
        });
        () async {
          int cloudVersion = await QuizzitAPi.version();
          int localVersion = await QuizzitAPi.localQuizVersion();
          if (localVersion <= cloudVersion) {
            bool result = await QuizzitAPi.getQuiz(downloadProgress);
            if (result == true) {
              loadingText = "Download Complete";
              await Future.delayed(const Duration(seconds: 2));
              // Check if the widget is still mounted before using the context
              if (!mounted) return;
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const StartPage()),
                  (Route<dynamic> route) => false);
            }
          }
        }();
      }
    });
  }

  void downloadProgress(received, total) {
    if (total != -1) {
      // Calculate the download progress
      double progress = (received / total * 100);
      setState(() {
        loadingText = 'Downloading ${progress.toStringAsFixed(2)}%';
      });
      if (kDebugMode) print('Download progress: $progress%');
    }
  }
}
