import 'dart:io';

import 'package:flag_quiz_26_12_2022/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

    static  String databaseName ="english";
  static Future<Database> connectToDatabase() async {
    if(dilSecenegi=="english"){
      databaseName="Flag.sqlite";
    }else{
      databaseName="FlagTurkce1.sqlite";
    }
    String pathOfDatabase = join(await getDatabasesPath(), databaseName);
    if (await databaseExists(pathOfDatabase)) {
      // ignore: avoid_print
    
      debugPrint("Database Name"+databaseName);
      debugPrint("***************************");
      debugPrint("***************************");
      debugPrint("***************************");
      debugPrint("Database already exists");
    } else {
      //you missed
      ByteData byteData = await rootBundle.load("database/$databaseName");
      List<int> bytes = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      await File(pathOfDatabase).writeAsBytes(bytes, flush: true);
       // ignore: avoid_print
   
      debugPrint("Copied");
      debugPrint("***************************");
      debugPrint("***************************");
      debugPrint("***************************");
      
    }
    return openDatabase(pathOfDatabase);
  }
}
