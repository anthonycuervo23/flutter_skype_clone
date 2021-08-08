import 'package:skype_clone/data/models/log.dart';

abstract class LogInterface {
  void init();

  void addLogs(LogModel log);

  Future<List<LogModel>> getLogs();

  void deleteLog(int logId);

  void close();
}
