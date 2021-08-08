import 'package:skype_clone/data/local_db/interface/log_interface.dart';
import 'package:skype_clone/data/models/log.dart';

class HiveMethods implements LogInterface {
  @override
  addLogs(LogModel log) {
    print('adding values tu Hive DB');
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
  LogInterface? init() {
    // TODO: implement init
    print('initialized hive database');
    return null;
  }
}
