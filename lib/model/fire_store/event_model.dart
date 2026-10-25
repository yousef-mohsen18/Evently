import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? title;
  String?type;
  Timestamp?dateAndTime;
  String?id;
  String?userId;
  String?desc;
  EventModel({this.title,this.id,this.dateAndTime,this.type,this.userId,this.desc});

  EventModel.fromFireStore(Map<String,dynamic>?data){
    title=data?["title"];
    type=data?["type"];
    dateAndTime=data?["dateAndTime"];
    id=data?["id"];
    userId=data?["userId"];
    desc=data?["desc"];
  }

 Map<String,dynamic> toFireStore(){
    return{
      "title":title ,
      "type":type,
      "dateAndTime":dateAndTime,
      "id":id,
      "userId":userId,
      "desc":desc
    };
  }

}