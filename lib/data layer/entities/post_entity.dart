import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable{
  String id;
  String? name;
  String? type;
  String? time;
  String? ingredients;
  String? steps;
  DateTime? dateTime;
  String? userId;
  String? dishPic;
  int? likes;


  PostEntity({required this.id, this.name = '', this.type = '', this.time = '', this.ingredients = '', this.steps = '', this.dateTime, this.dishPic = '', this.userId = '', this.likes = 0});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'type': type,
      'name': name,
      'time': time,
      'ingredients': ingredients,
      'steps': steps,
      'dateTime': dateTime,
      'userId': userId,
      'dishPic': dishPic,
      'likes': likes
    };
  }

  static PostEntity fromMap(Map<String, dynamic> doc){

    return PostEntity(
        id: doc['id'].toString(),
        name: doc['name'].toString(),
        type: doc['type'].toString(),
        time: doc['time'].toString(),
        ingredients: doc['ingredients'].toString(),
        steps: doc['steps'].toString(),
        dateTime: (doc['dateTime'] as Timestamp).toDate(),
        userId: doc['userId'].toString(),
        dishPic: doc['dishPic'].toString(),
        likes: doc['likes']
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, type, time, ingredients, steps, dateTime, userId, dishPic, likes];

}
