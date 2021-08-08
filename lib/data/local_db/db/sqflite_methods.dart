import 'package:skype_clone/data/local_db/interface/log_interface.dart';
import 'package:skype_clone/data/models/log.dart';

class SqfliteMethods implements LogInterface {
  @override
  addLogs(LogModel log) {
    print('Adding values to Sqflite DB');
    // TODO: implement addLogs
    throw UnimplementedError();
  }

  @override
  LogInterface close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  deleteLog(int logId) {
    // TODO: implement deleteLog
    throw UnimplementedError();
  }

  @override
  Future<List<LogModel>> getLogs() {
    // TODO: implement getLogs
    throw UnimplementedError();
  }

  @override
  LogInterface init() {
    print('initialized Sqflite DB');
    throw UnimplementedError();
  }
}
