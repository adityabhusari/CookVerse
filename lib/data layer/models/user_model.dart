import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:last/data%20layer/entities/user_entity.dart';

class UserModel extends Equatable{
  final String id;
  String? email;
  String? name;
  String? photo;
  List<dynamic>? followers;
  List<dynamic>? following;
  List<dynamic>? myRecipes;
  List<dynamic>? myBookmarks;
  List<dynamic>? myLiked;

  UserModel({required this.id, this.email = '', this.name = '', this.photo = '', this.following = const [], this.followers = const [], this.myRecipes = const [], this.myBookmarks = const [], this.myLiked = const []});

  static UserModel empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  UserModel copyWith({
      String? id,
      String? email,
      String? name,
      String? photo,
      List<dynamic>? followers,
      List<dynamic>? following,
      List<dynamic>? myRecipes,
      List<dynamic>? myBookmarks,
      List<dynamic>? myLiked
  }){
        return UserModel(
          id: id ?? this.id,
          email: email ?? this.email,
          name: name ?? this.name,
          following: following ?? this.following,
          followers: followers ?? this.followers,
          myBookmarks: myBookmarks ?? this.myBookmarks,
          myRecipes: myRecipes?? this.myRecipes,
          myLiked: myLiked ?? this.myLiked,
          photo: photo ?? this.photo
        );
      }

    UserEntity toUserEntity(){
      return UserEntity(
          id: id,
          email: email,
          name: name,
          photo: photo,
          followers: followers,
          following: following,
          myRecipes: myRecipes,
          myBookmarks: myBookmarks,
          myLiked: myLiked
      );
    }

  static UserModel fromUserEntity(UserEntity userEntity){
    return UserModel(
        id: userEntity.id,
        email: userEntity.email,
        name: userEntity.name,
        photo: userEntity.photo,
        followers: userEntity.followers,
        following: userEntity.following,
        myRecipes: userEntity.myRecipes,
        myBookmarks: userEntity.myBookmarks,
        myLiked: userEntity.myLiked
    );
  }

  @override
  String toString() {
    return '''User{
      id: $id,
      email: $email,
      name: $name,
      photo: $photo,
      followers: $followers,
      following: $following,
      myRecipes: $myRecipes,
      myBookmarks: $myBookmarks,
      myLiked: $myLiked
    }''';
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id, email, name, photo, following, followers, myRecipes, myBookmarks, myLiked];

}
