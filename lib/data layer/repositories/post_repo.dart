import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:last/data%20layer/entities/post_entity.dart';
import 'package:last/data%20layer/models/post_model.dart';
import 'package:last/data%20layer/models/user_model.dart';
import 'package:uuid/uuid.dart';

class PostRepository{

  final postCollection = FirebaseFirestore.instance.collection('posts');

  Future<Post> createPost(Post post) async{
    try{
      post.dateTime = DateTime.now();
      await postCollection.doc(post.id).set(
        post.toPostEntity().toMap()
      );
      return post;
    }catch(e){
        print(e.toString());
        rethrow;
    }
  }

  Future<List<Post>> getPosts() async{
    try{
      return postCollection.
        get().
        then((querySnapshot) =>
           querySnapshot.docs.
           map((doc) => Post.fromPostEntity(PostEntity.fromMap(doc.data()))).toList()
      );
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<Post> getPost(String postId) async{
    try{
      return postCollection.doc(postId).get().then((value) => Post.fromPostEntity(PostEntity.fromMap(value.data()!)));
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<String> uploadDishPic(String file, String postId, String userId) async{
    try{
      File imgFile = File(file);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('$userId/DISHPICS/${postId}_lead');
      await firebaseStorageRef.putFile(imgFile);
      String url = await firebaseStorageRef.getDownloadURL();
      return url;
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<void> likeUnlikePost(bool isLiked, String pid) async{
    try{
       if (isLiked){
         await postCollection.doc(pid).update({
           "likes": FieldValue.increment(-1)
         });
       }else{
          await postCollection.doc(pid).update({
            "likes": FieldValue.increment(1)
          });
       }
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<List<Post>> getUserPosts(List<dynamic> myRecipes) async{
    try{
      List<Post> postList = [];
      for (String recipe in myRecipes){
        Post post = await postCollection.doc(recipe).get().then((value) {
          return Post.fromPostEntity(PostEntity.fromMap(value.data()!));
        });
        postList.add(post);
      }
      return postList;
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }
}