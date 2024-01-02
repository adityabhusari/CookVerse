import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:last/data%20layer/entities/user_entity.dart';

import '../entities/post_entity.dart';

class Post extends Equatable{
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

  Post({required this.id, this.name = '', this.type = '', this.time = '', this.ingredients = '', this.steps = '', this.dateTime, this.dishPic = '', this.userId = '', this.likes = 0});

  static Post empty = Post(
      id: '',
      name: '',
      userId: '',
      dateTime: DateTime.now(),
      dishPic: '',
      steps: '',
      ingredients: '',
      time: '',
      type: '',
      likes: 0
  );

  bool get isEmpty => this == Post.empty;

  bool get isNotEmpty => this != Post.empty;

  Post copyWith({
    String? id,
    String? name,
    String? type,
    String? time,
    String? ingredients,
    String? steps,
    DateTime? dateTime,
    String? userId,
    String? dishPic,
    int? likes
  }){
    return Post(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      time: time ?? this.time,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      dateTime: dateTime?? this.dateTime,
      userId: userId?? this.userId,
      dishPic: dishPic?? this.dishPic,
      likes: likes?? this.likes
    );
  }

  PostEntity toPostEntity(){
    return PostEntity(
        id: id,
        type: type,
        name: name,
        time: time,
        ingredients: ingredients,
        steps: steps,
        dateTime: dateTime,
        userId: userId,
        dishPic: dishPic,
        likes: likes
    );
  }

  static Post fromPostEntity(PostEntity postEntity){
    return Post(
        id: postEntity.id,
        type: postEntity.type,
        name: postEntity.name,
        time: postEntity.time,
        ingredients: postEntity.ingredients,
        steps: postEntity.steps,
        dateTime: postEntity.dateTime,
        userId: postEntity.userId,
        dishPic: postEntity.dishPic,
        likes: postEntity.likes
    );
  }

  @override
  String toString() {
    return '''Post{
      id: $id,
      name: $name,
      userId: $userId,
      dateTime: $dateTime,
      dishPic: $dishPic,
      steps: $steps,
      ingredients: $ingredients,
      time: $time,
      type: $type,
      likes: $likes
    }''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, type, time, ingredients, steps, dateTime, userId, dishPic, likes];

}
