import 'package:skype_clone/data/local_db/db/hive_methods.dart';
import 'package:skype_clone/data/local_db/db/sqflite_methods.dart';
import 'package:skype_clone/data/models/log.dart';

class LogRepository {
  static dynamic? dbObject;
  static bool? isHive;

  static void init({required bool isHive}) {
    dbObject = isHive ? HiveMethods() : SqfliteMethods();
    dbObject.init();
  }

  static void addLogs(LogModel log) => dbObject.addLogs(log);

  static void deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static void getLogs() => dbObject.getLogs();

  static void close() => dbObject.close();
}
