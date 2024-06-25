import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzit/src/utils/constants.dart';
import 'dart:io';

final dio = Dio();

class QuizzitAPi {
  static Future<Response<dynamic>> status() async {
    /**
   * get api status
   */
    try {
      return await dio.get(apiBaseRoute + apiStatusRoute);
    } catch (e) {
      return Response(requestOptions: RequestOptions(data: {}));
    }
  }

  static Future<int> version() async {
    /**
   * get latest quiz version
   */
    Response<dynamic> response = await dio.get(apiBaseRoute + apiVersionRoute);
    if (response.statusCode == 200) {
      return response.data["version"];
    }
    return 0;
  }

  static Future<bool> getQuiz(progressCallback) async {
    /**
     * Save quiz file localy File 
     */
    String savePath =
        (await getApplicationDocumentsDirectory()).path + quizFile;

    try {
      await dio.download(apiBaseRoute + apiQuizRoute, savePath,
          onReceiveProgress: progressCallback);
      return true;
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  static Future<int> localQuizVersion() async {
    /**
     * comapare versions
     * Return: true for newer false for No
     */
    String filePath =
        (await getApplicationDocumentsDirectory()).path + quizFile;
    if (File(filePath).existsSync()) {
      File(filePath).readAsString().then((String contents) {
        Map<dynamic, dynamic> content = jsonDecode(contents);

        int version = content["version"];
        return version;
      });
    }
    return 0;
  }

  static Future<List<dynamic>> localQuizData() async {
    /**
     * comapare versions
     * Return: true for newer false for No
     */
    String filePath =
        (await getApplicationDocumentsDirectory()).path + quizFile;
    if (File(filePath).existsSync()) {
      if (kDebugMode) {
        print("fileExist");
      }
      String contents = await File(filePath).readAsString();
      Map<dynamic, dynamic> content = jsonDecode(contents);

      List<dynamic> quizData = content["quiz"];
      return quizData;
    }
    return [];
  }

  static Future<List<dynamic>> getQuizQuestions(
      String category, String difficulty) async {
    List<dynamic> quiz = await localQuizData();

    List<dynamic> categorized =
        quiz.where((element) => element["category"] == category).toList();

    if (difficulty == "Random") {
      categorized.shuffle();
      return categorized.take(10).toList();
    } else {
      categorized = categorized
          .where((element) => element["difficulty"] == difficulty.toLowerCase())
          .toList();
      print("categorized");
      print(categorized);
      categorized.shuffle();
      return categorized.take(10).toList();
    }
  }
}
