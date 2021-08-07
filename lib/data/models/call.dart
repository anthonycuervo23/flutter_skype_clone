import 'package:skype_clone/data/constants/call_fields.dart';

class CallModel {
  CallModel({
    this.callerId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    this.receiverName,
    this.receiverPic,
    this.channelId,
    this.hasDialled,
  });

  Map<String, dynamic> toMap(CallModel call) {
    final Map<String, dynamic> callMap = <String, dynamic>{};
    callMap[CallFields.callerId] = call.callerId;
    callMap[CallFields.callerName] = call.callerName;
    callMap[CallFields.callerPic] = call.callerPic;
    callMap[CallFields.receiverId] = call.receiverId;
    callMap[CallFields.receiverName] = call.receiverName;
    callMap[CallFields.receiverPic] = call.receiverPic;
    callMap[CallFields.channelId] = call.channelId;
    callMap[CallFields.hasDialled] = call.hasDialled;
    return callMap;
  }

  CallModel.fromMap(Map callMap) {
    this.callerId = callMap[CallFields.callerId];
    this.callerName = callMap[CallFields.callerName];
    this.callerPic = callMap[CallFields.callerPic];
    this.receiverId = callMap[CallFields.receiverId];
    this.receiverName = callMap[CallFields.receiverName];
    this.receiverPic = callMap[CallFields.receiverPic];
    this.channelId = callMap[CallFields.channelId];
    this.hasDialled = callMap[CallFields.hasDialled];
  }

  String? callerId;
  String? callerName;
  String? callerPic;
  String? receiverId;
  String? receiverName;
  String? receiverPic;
  String? channelId;
  bool? hasDialled;
}
