import 'package:flag_quiz_26_12_2022/databasehelper.dart';
import 'package:flag_quiz_26_12_2022/flags.dart';
import 'package:flutter/material.dart';

class Flagdao {
  static Future<List<Flags>> randomFlag() async {
    var db = await DatabaseHelper.connectToDatabase();
    late List<Map<String, dynamic>> myList;
    try {
      myList =
          await db.rawQuery("Select * From Flag ORDER BY RANDOM() LIMIT 10");
    } catch (e) {
      debugPrint("Hata var  ${e}");
    }
  debugPrint("Ülke Adı : ${myList[0]["Name"]}");
  debugPrint("Ülke Adı : ${myList[1]["Name"]}");
  debugPrint("Ülke Adı : ${myList[2]["Name"]}");
    return List.generate(myList.length, (index) {
 
        var satir = myList[index];
          debugPrint(satir["Name"]);
           debugPrint("${satir["Id"]}");
          debugPrint(satir["FlagPicture"]);
        return Flags(satir["Id"], satir["Name"], satir["FlagPicture"]);
      
    });
  }

  static Future<List<Flags>> random3Flag(int id) async {
    var db = await DatabaseHelper.connectToDatabase();
    late List<Map<String, dynamic>> myList;

    try {
      myList = await db.rawQuery(
          "Select * From Flag Where Id != $id  ORDER BY RANDOM() LIMIT 3");
    } catch (e) {
      debugPrint("Hata limit 3 de var :$e");
    }
    return List.generate(
      myList.length,
      (index) {
        var satir = myList[index];
        return Flags(satir["Id"], satir["Name"], satir["FlagPicture"]);
      },
    );
  }
}
