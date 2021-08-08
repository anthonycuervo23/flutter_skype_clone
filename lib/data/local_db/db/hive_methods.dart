import 'dart:io';

import 'package:hive/hive.dart';
import 'package:skype_clone/data/local_db/interface/log_interface.dart';
import 'package:skype_clone/data/models/log.dart';
import 'package:path_provider/path_provider.dart';

class HiveMethods implements LogInterface {
  String hiveBox = 'Call_Logs';

  @override
  Future<void> init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  @override
  Future<int> addLogs(LogModel log) async {
    final Box<Map<String, dynamic>> box =
        await Hive.openBox<Map<String, dynamic>>(hiveBox);

    final Map<String, dynamic> logMap = log.toMap(log);

    final int idOfInput = await box.add(logMap);

    close();

    return idOfInput;
  }

  Future<void> updateLogs(int index, LogModel newLog) async {
    final Box<Map<String, dynamic>> box =
        await Hive.openBox<Map<String, dynamic>>(hiveBox);

    final Map<String, dynamic> newLogMap = newLog.toMap(newLog);

    box.putAt(index, newLogMap);

    close();
  }

  @override
  Future<List<LogModel>> getLogs() async {
    final Box<Map<String, dynamic>> box =
        await Hive.openBox<Map<String, dynamic>>(hiveBox);

    final List<LogModel> logList = <LogModel>[];

    for (int i = 0; i < box.length; i++) {
      final Map<String, dynamic>? logMap = box.getAt(i);

      logList.add(LogModel.fromMap(logMap!));
    }

    return logList;
  }

  @override
  Future<void> deleteLog(int logId) async {
    final Box<Map<String, dynamic>> box =
        await Hive.openBox<Map<String, dynamic>>(hiveBox);

    await box.deleteAt(logId);
  }

  @override
  void close() => Hive.close();
}
