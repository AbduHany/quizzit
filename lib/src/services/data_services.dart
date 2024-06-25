import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quizzit/src/utils/constants.dart';
import 'package:random_name_generator/random_name_generator.dart';

class UserData {
  static Future<bool> firstTime() async {
    String filePath =
        (await getApplicationDocumentsDirectory()).path + userData;
    if (File(filePath).existsSync()) {
      return false;
    } else {
      File(filePath).writeAsStringSync(jsonEncode({
        "firstName": RandomNames(Zone.egypt).name(),
        "lastName": RandomNames(Zone.egypt).manName(),
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
