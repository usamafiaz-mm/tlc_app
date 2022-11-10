import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tlc_app/models/form_data_model.dart';

class DBHandler {
  static const String tblName = "FormData";
  static Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tlc.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE "FormData" ( "id" INTEGER, "formValue" TEXT, creationDate INTEGER,endingDate INTEGER, status INTEGER, PRIMARY KEY("id" AUTOINCREMENT))');
    });
    return database;
  }

  static Future<int?> insertFormData(FormDataModel formDataModel) async {
    Database database = await getDatabase();
    formDataModel.id = await database.insert(tblName, formDataModel.toJson());
    return formDataModel.id;
  }

  static updateFormData(String formDataModel, int id) async {
    Database database = await getDatabase();
    int returnedID = await database.update(
        tblName, {"formValue": formDataModel},
        where: "id=?", whereArgs: [id]);
    return returnedID;
  }

  static finalSubmission(String formDataModel, int id) async {
    Database database = await getDatabase();
    int returnedID = await database.update(
        tblName,
        {
          "formValue": formDataModel,
          "status": 1,
          "endingDate": DateTime.now().millisecondsSinceEpoch
        },
        where: "id=?",
        whereArgs: [id]);
    return returnedID;
  }

  static Future<List<Map<String, dynamic>>> getMonitoringData() async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> list = await database.rawQuery(
        "Select * from $tblName where status = 0 order by creationDate desc");
    return list;
  }

  static Future<List<Map<String, dynamic>>> getSyncData() async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> list =
        await database.rawQuery("Select * from $tblName where status = 1");
    return list;
  }
  // static Future<FormDataModel> updateData(
  //     int id, FormDataModel dataModel) async {
  //   Database database = await getDatabase();
  //   dataModel.id = await database
  //       .update(tblName, dataModel.toJson(), where: "id=?", whereArgs: [id]);
  //
  //   return dataModel;
  // }
}
