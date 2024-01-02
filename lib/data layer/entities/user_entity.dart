import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String id;
  final String? email;
  final String? name;
  final String? photo;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  final List<dynamic>? myRecipes;
  final List<dynamic>? myBookmarks;
  final List<dynamic>? myLiked;


  const UserEntity({required this.id, this.email = '', this.name = '', this.photo = '', this.following = const [], this.followers= const [], this.myRecipes= const [], this.myBookmarks= const [], this.myLiked = const []});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
        'id': id,
        'email': email,
        'name': name,
        'photo': photo,
        'followers': followers,
        'following': following,
        'myRecipes': myRecipes,
        'myBookmarks': myBookmarks,
        'myLiked': myLiked
    };
  }

  static UserEntity fromMap(Map<String, dynamic> doc){
    return UserEntity(
        id: doc['id'].toString(),
        name: doc['name'].toString(),
        email: doc['email'].toString(),
        photo: doc['photo'].toString(),
        following: doc['following'],
        followers: doc['followers'],
        myRecipes: doc['myRecipes'],
        myBookmarks: doc['myBookmarks'],
        myLiked: doc['myLiked']
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, name, photo, following, followers, myRecipes, myBookmarks, myLiked];

}
