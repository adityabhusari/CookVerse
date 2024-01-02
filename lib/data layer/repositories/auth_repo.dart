import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:last/data%20layer/entities/user_entity.dart';

import '../models/user_model.dart';

class UserRepository{
  final FirebaseAuth _firebaseAuth;

  //If we already have an instance no need to create another instance of firebase
  UserRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final userCollection = FirebaseFirestore.instance.collection('users');

  //AUTHENTICATION
  UserModel get getCurrUserModel{
    return _firebaseAuth.currentUser != null ? toUserModel(_firebaseAuth.currentUser) : UserModel.empty;
  }

  UserModel toUserModel(User? fbUser){
    UserModel userModel = UserModel.empty;
    return fbUser != null ? userModel.copyWith(id: fbUser.uid, name: fbUser.displayName, email: fbUser.email) : UserModel.empty;
  }

  Stream<UserModel> get userStream {
    return _firebaseAuth.authStateChanges().map(toUserModel);
  }

  Future<UserModel> signUpWithEmailAndPass(UserModel userModel, String password) async{
    try{
      //assiging just a uid to our input userModel so that we can confirm it is authenticated and set it in our db + same instance of user
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: password);
      //no need to reset the email or anything as it using this.email in the userModel class
      userModel = userModel.copyWith(
        id: userCredential.user!.uid
      );
      return userModel;

    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<void> logInWithEmailAndPass(String email, String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<void> logOut() async{
    try{
      await _firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  //FIRE-STORE
  Future<void> setUser(UserModel userModel) async{
    try{
      await userCollection.doc(userModel.id).set(userModel.toUserEntity().toMap());
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<UserModel> getUser(String userId) async{
    try{
      return userCollection.doc(userId).get().then((value) {
        return UserModel.fromUserEntity(UserEntity.fromMap(value.data()!));
      });
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  //UPDATE USER PROFILE PIC
  Future<String> updateUserProfilePic(String profilePic, String id) async{
    try{
      File imgFile = File(profilePic);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('$id/PP/${id}_lead');
      await firebaseStorageRef.putFile(imgFile);
      String url = await firebaseStorageRef.getDownloadURL();
      await userCollection.doc(id).update({'photo': url});
      return url;
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }
  
  //UPDATE USERNAME
  Future<String> updateUsername(String name, String uid) async{
    try{
      await userCollection.doc(uid).update({"name": name});
      return name;
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  //ADD POST TO USER
  Future<List<dynamic>> addPostToUser(String postId, String userId) async{
    try{
      await userCollection.doc(userId).update({
        "myRecipes": FieldValue.arrayUnion([postId])
      });
      return userCollection.doc(userId).get().then((value) => value.get('myRecipes'));
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  //LIKE UNLIKE POST
  Future<List<dynamic>> isLiked(String userId, String postId) async{
    try{
      final value = await userCollection.doc(userId).get();
      final List<dynamic> myLiked = value.get('myLiked');
      bool isLiked = myLiked.contains(postId);
      if (isLiked){
        await userCollection.doc(userId).update({
          "myLiked": FieldValue.arrayRemove([postId])
        });
      }else{
        await userCollection.doc(userId).update({
          "myLiked": FieldValue.arrayUnion([postId])
        });
      }
        final v = await userCollection.doc(userId).get();
        final List<dynamic> myNewLiked = v.get('myLiked');
        return [myNewLiked, isLiked];

    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  //BOOKMARK
  Future<List<dynamic>> isBookmarked(String userId, String postId) async{
    try{
      final value = await userCollection.doc(userId).get();
      final List<dynamic> myBookmarks = value.get('myBookmarks');
      bool isBookmarked = myBookmarks.contains(postId);
      if (isBookmarked){
        await userCollection.doc(userId).update({
          "myBookmarks": FieldValue.arrayRemove([postId])
        });
      }else{
        await userCollection.doc(userId).update({
          "myBookmarks": FieldValue.arrayUnion([postId])
        });
      }
      final v = await userCollection.doc(userId).get();
      final List<dynamic> myNewBookmarked = v.get('myBookmarks');
      return [myNewBookmarked, isBookmarked];

    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  //FOLLOW UNFOLLOW
  Future<List<dynamic>> followUnfollow(String user, String follower) async{
    try{
      final valueUser = await userCollection.doc(user).get();
      List<dynamic> followers = valueUser.get('followers');
      bool isFollower = followers.contains(follower);
      if (isFollower){
        await userCollection.doc(follower).update({
          "following": FieldValue.arrayRemove([user])
        });
        await userCollection.doc(user).update({
          "followers": FieldValue.arrayRemove([follower])
        });
      }else{
        await userCollection.doc(follower).update({
          "following": FieldValue.arrayUnion([user])
        });
        await userCollection.doc(user).update({
          "followers": FieldValue.arrayUnion([follower])
        });
      }
      followers = await userCollection.doc(user).get().then((value) {
        return value.get('followers');
      });
      print(followers);
      return [followers.length, isFollower];

    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

}
