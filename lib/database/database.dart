import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  final String pathDB = "db.sqlite";

  Future<Database> accessDb() async {
    WidgetsFlutterBinding.ensureInitialized();

    String dbPath = join(await getDatabasesPath(), pathDB);

    if (await databaseExists(dbPath)) {
      print('database direct access successful');
    } else {
      ByteData data = await rootBundle.load('databases/${pathDB}');

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await Directory(dirname(dbPath)).create(recursive: true);
      await File(dbPath).writeAsBytes(bytes, flush: true);

      print('database created and access successful');
    }
    var database = await openDatabase(dbPath, version: 1);
    return database;
  }
}
