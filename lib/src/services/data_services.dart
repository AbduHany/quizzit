import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quizzit/src/utils/constants.dart';
import 'package:unique_name_generator/unique_name_generator.dart';

class UserData {
  static Future<bool> firstTime() async {
    String filePath =
        (await getApplicationDocumentsDirectory()).path + userData;
    if (File(filePath).existsSync()) {
      return false;
    } else {
      var nameGenerator = UniqueNameGenerator(
        dictionaries: [adjectives, animals],
        style: NameStyle.capital,
        separator: ' ',
      );
      String fullName = nameGenerator.generate();
      String firstName = fullName.split(' ')[0];
      String lastName = fullName.split(' ')[1];
      File(filePath).writeAsStringSync(jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "gender": "Male",
        "birthDate": DateTime.now().toString().substring(0, 10),
      }));
      return true;
    }
  }

  static Future<String> getName() async {
    String filePath =
        (await getApplicationDocumentsDirectory()).path + userData;
    if (File(filePath).existsSync()) {
      String contents = await File(filePath).readAsString();
      Map content = jsonDecode(contents);
      return content["firstName"] + " " + content["lastName"];
    }
    return "";
  }

  static Future<Map<dynamic, dynamic>> getData() async {
    String filePath =
        (await getApplicationDocumentsDirectory()).path + userData;
    if (File(filePath).existsSync()) {
      String contents = await File(filePath).readAsString();
      Map content = jsonDecode(contents);
      return content;
    }
    return {};
  }
}

class StatsData {
  static Future<bool> firstTime() async {
    String filePath =
        (await getApplicationDocumentsDirectory()).path + statData;
    if (File(filePath).existsSync()) {
      // Handling Strike score calculation
      Map content = jsonDecode(File(filePath).readAsStringSync());
      DateTime today = DateTime.now();
      DateTime lastLogin = DateTime.parse(content["LastLogin"]);
      int difference = today.difference(lastLogin).inDays;
      if (difference == 0) {
        return false;
      } else if (difference == 1) {
        content['Strike'] += 1;
        content['LastLogin'] = today.toIso8601String();
        File(filePath).writeAsStringSync(jsonEncode(content));
      } else if (difference > 1) {
        content['Strike'] = 0;
        content['LastLogin'] = today.toIso8601String();
        File(filePath).writeAsStringSync(jsonEncode(content));
      }
      return false;
    } else {
      File(filePath).writeAsStringSync(jsonEncode({
        "StartedQuiz": 0,
        "CompletedQuiz": 0,
        "CorrectAnswers": 0,
        "WrongAnswers": 0,
        "LastLogin": DateTime.now().toIso8601String(),
        "Strike": 0,
      }));
      return true;
    }
  }

  static Future<Map<dynamic, dynamic>> getData() async {
    String filePath =
        (await getApplicationDocumentsDirectory()).path + statData;
    if (File(filePath).existsSync()) {
      String contents = await File(filePath).readAsString();
      Map content = jsonDecode(contents);
      return content;
    }
    return {};
  }
}
