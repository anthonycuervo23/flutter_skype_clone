import 'package:skype_clone/data/constants/log_fields.dart';

class LogModel {
  int? logId;
  String? callerName;
  String? callerPic;
  String? receiverName;
  String? receiverPic;
  String? callStatus;
  String? timestamp;

  LogModel({
    this.logId,
    this.callerName,
    this.callerPic,
    this.receiverName,
    this.receiverPic,
    this.callStatus,
    this.timestamp,
  });

  Map<String, dynamic> toMap(LogModel log) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[LogFields.logId] = log.logId;
    data[LogFields.callerName] = log.callerName;
    data[LogFields.callerPic] = log.callerPic;
    data[LogFields.receiverName] = log.receiverName;
    data[LogFields.receiverPic] = log.receiverPic;
    data[LogFields.callStatus] = log.callStatus;
    data[LogFields.timestamp] = log.timestamp;
    return data;
  }

  LogModel.fromMap(Map<String, dynamic> data) {
    logId = data[LogFields.logId];
    callerName = data[LogFields.callerName];
    callerPic = data[LogFields.callerPic];
    receiverName = data[LogFields.receiverName];
    receiverPic = data[LogFields.receiverPic];
    callStatus = data[LogFields.callStatus];
    timestamp = data[LogFields.timestamp];
  }
}
