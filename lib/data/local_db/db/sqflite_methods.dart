import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:skype_clone/data/constants/log_fields.dart';
import 'package:skype_clone/data/local_db/interface/log_interface.dart';
import 'package:skype_clone/data/models/log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteMethods implements LogInterface {
  late Database _db;

  String databaseName = 'LogDB';

  String tableName = 'Call_Logs';

  //Columns
  String id = LogFields.logId;
  String callerName = LogFields.callerName;
  String callerPic = LogFields.callerPic;
  String receiverName = LogFields.receiverName;
  String receiverPic = LogFields.receiverPic;
  String callStatus = LogFields.callStatus;
  String timestamp = LogFields.timestamp;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print('db was null, now we are awaiting for it');
    _db = await init();
    return _db;
  }

  @override
  Future<Database> init() async {
    final Directory dir = await getApplicationDocumentsDirectory();

    final String path = join(dir.path, databaseName);

    final Database db =
        await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    final String createTableQuery =
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $callerName TEXT, $callerPic TEXT, $receiverName TEXT, $receiverPic TEXT, $callStatus TEXT, $timestamp TEXT)';

    await db.execute(createTableQuery);
    print('table created');
  }

  @override
  Future<void> addLogs(LogModel log) async {
    final Database dbClient = await db;

    await dbClient.insert(tableName, log.toMap(log));
  }

  @override
  Future<int> deleteLog(int logId) async {
    final Database dbClient = await db;

    return dbClient
        .delete(tableName, where: '$id = ?', whereArgs: <Object?>[logId]);
  }

  Future<void> updateLogs(LogModel log) async {
    final Database dbClient = await db;

    await dbClient.update(tableName, log.toMap(log),
        where: '$id = ?', whereArgs: <Object?>[log.logId]);
  }

  @override
  Future<List<LogModel>> getLogs() async {
    try {
      final Database dbClient = await db;
      // List<Map<String, dynamic>> maps =
      //     await dbClient.rawQuery(' SELECT * FROM $tableName');
      final List<Map<String, dynamic>> maps = await dbClient.query(
        tableName,
        columns: <String>[
          id,
          callerName,
          callerPic,
          receiverName,
          receiverPic,
          callStatus,
          timestamp,
        ],
      );

      final List<LogModel> logList = <LogModel>[];

      if (maps.isNotEmpty) {
        for (final Map<String, dynamic> map in maps) {
          logList.add(LogModel.fromMap(map));
        }
      }
      return logList;
    } catch (e) {
      print(e);
      return <LogModel>[];
    }
  }

  @override
  Future<void> close() async {
    final Database dbClient = await db;
    dbClient.close();
  }
}
