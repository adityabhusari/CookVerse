# CookVerse

Welcome to CookVerse, the ultimate platform for foodies and home-kitchen chefs! it's a global community you can discover and learn exciting recipes crafted by passionate chefs from around the world. What's more, you can showcase your own culinary masterpieces and connect with fellow food enthusiasts.

## Key Features

- **Discover Recipes:** Explore a diverse collection of recipes covering various cuisines and skill levels.
- **Learn from Chefs Worldwide:** Get inspired by the creativity of chefs globally, each sharing their unique recipes and cooking techniques.
- **Share Your Masterpieces:** Showcase your culinary creations with the CookVerse community, spreading the joy of home-cooked goodness.
- **Support Fellow Foodies:** Engage with a vibrant community of food enthusiasts showing your support by liking and following their profiles.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Ensure you have the necessary dependencies installed, and your authentication system is integrated. Once set up, you can navigate to the home page, where a feast of culinary inspiration awaits.

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  flow_builder: ^0.0.10
  cloud_firestore: ^4.13.6
  image_picker: ^1.0.5
  firebase_storage: ^11.5.6
  image_cropper: ^5.0.1
  uuid: ^4.3.1
  intl: ^0.19.0
  video_player: ^2.8.2
  appinio_video_player: ^1.2.2
  google_sign_in: ^6.2.1

Refer to the pubspec.ymal file for more information...

# Bloc Info
All the provided code snippet represent only a small part of the main bloc code involved as there are many blocs invovled to control a single page. 
To refer all the blocs used for application please navigate to the following folder of the repository. 
[Blocs](https://github.com/adityabhusari/Recipe_Social_media/tree/main/lib/buisness%20layer/blocs)

# Authentication in CookVerse

This section outlines the authentication features in CookVerse, powered by Bloc architecture and Firebase Authentication.

![Screenshot_1](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/34751c25-9214-4267-9aa1-4b8fe361c648)
![Screenshot_2](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/23a7cae5-9a6a-4557-acc3-8e3a79e9292b)


## Features

### Sign In with Google

CookVerse provides a seamless Sign In with Google option, allowing users to access the app effortlessly with their Google credentials. Here's how you can integrate it into your app:

1. **Enable Google Sign-In:**
   - Follow the instructions in the [Google Sign-In documentation](https://pub.dev/packages/google_sign_in) to set up Google Sign-In for your Flutter project.

2. **Integrate with Firebase Authentication:**
   - Connect your Google Sign-In with Firebase Authentication by following the steps in the [Firebase Authentication documentation](https://firebase.flutter.dev/docs/auth/social#google).

3. **Implement Bloc for Authentication:**
   - Utilize the Bloc architecture to manage the authentication state. The [Bloc library](https://pub.dev/packages/flutter_bloc) is a powerful state management solution.

4. **Update UI:**
   - Reflect the authentication state in your UI to provide a seamless and responsive user experience.

### Forgot Password Feature

CookVerse understands the importance of account recovery. The app incorporates a Forgot Password feature to assist users in resetting their passwords:

1. **Set Up Firebase Authentication:**
   - Ensure you have Firebase Authentication set up for your project. Refer to the [Firebase Authentication documentation](https://firebase.flutter.dev/docs/auth/email-link#set-up-emailaddress-and-emailactionlinkgenerator) for guidance.

2. **Implement Bloc for Password Reset:**
   - Extend your authentication Bloc to handle the Forgot Password feature. Dispatch events to initiate password reset requests and handle responses accordingly.

3. **Create UI Components:**
   - Design intuitive UI components to collect user information for the password reset process.

4. **Handle Email Verification:**
   - Follow Firebase's guidance on handling email verification for password reset. Utilize the [Firebase Auth API](https://pub.dev/packages/firebase_auth) for efficient communication with Firebase Authentication.

## Example Code Snippets

### Sign In with Google

```dart
// Example code for Google Sign-In using Flutter and Firebase
// Make sure to integrate it with your authentication Bloc.

 Future<UserModel> signInWithGoogle(UserModel userModel) async{
    try{
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credentials);
      userModel = userModel.copyWith(
        email: userCredential.user!.email,
        name: userCredential.user!.displayName,
        id: userCredential.user!.uid
      );

      return userModel;

    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

// Example code for initiating password reset using Flutter and Firebase
// Integrate it with your authentication Bloc.

 Future<void> forgotPass(String email) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

```


# CookVerse: Home Page with Bloc State Management

Welcome to the vibrant home page of CookVerse, powered by the robust Bloc state management system. Explore a curated list of recipes from chefs worldwide, engage with the community, and share your culinary creations effortlessly.

## Example Screenshot

![Screenshot_3](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/e7a7dc48-6e30-4f3a-81ea-411c2fabd25d)

## Recipe Cards

The heart of CookVerse lies in its recipe cards, intelligently crafted with Bloc state management to provide an immersive experience:

- **Recipe Image:** A tempting visual preview of the dish.
- **Date of Recipe:** The date when the recipe was shared with the CookVerse community.
- **Likes:** The number of likes the recipe has received from fellow food enthusiasts.
- **Follower Indicator:** Indicates if you are following the chef who posted the recipe.
- **Estimated Cooking Time:** The approximate time required to prepare the dish.

## Navigation Bar

Discover a user-friendly navigation bar at the bottom of the home page, enhanced by the power of Bloc state management:

- **Post Recipe:** Share your culinary masterpieces seamlessly. The Bloc pattern ensures a smooth flow of data and state updates during the posting process.
- **Search:** Utilize the search feature to explore recipes effortlessly. Bloc state management ensures efficient data handling for a responsive experience.
- **Profile:** Manage your CookVerse profile with ease. Bloc ensures your profile information and activities are synchronized across the app.

### Recipe Card Bloc Logic
```dart
class GetPostsBloc extends Bloc<GetPostEvent, GetPostsState>{

  final PostRepository postRepository;

  GetPostsBloc({required this.postRepository}) : super(GetPostsState.initial()){
    on<GetPostEvent>((event, emit) async{
      emit(GetPostsState.loading());
      try{
        final List<Post> postList = await postRepository.getPosts();
        emit(GetPostsState.success(postList));
      }catch(e){
        print(e.toString());
        emit(GetPostsState.failure());
      }
    });
  }
}
```

# CookVerse: Profile Section

The profile section offers features like your profile picture, name, recipe list, bookmarked recipes, and follower/following information.

## Profile Overview

### Profile Picture and Name

Your profile begins with a personalized touch, displaying your chosen profile picture and your CookVerse username. Make your profile uniquely yours!

### Your Recipes

Explore a curated list of recipes that you have shared with the CookVerse community.

### Bookmarked Recipes

Keep track of recipes that inspire you by bookmarking them. The bookmarked recipes section displays a list of dishes you've saved for future reference, allowing you to easily revisit and recreate those culinary delights.

### Follower and Following Information

Connect with fellow food enthusiasts by checking your follower and following counts. See who appreciates your culinary skills and discover chefs who inspire you. The follower/following information fosters a sense of community within CookVerse.

## Example Screenshot

![Screenshot_4](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/18d8eb89-f8ba-4545-b7ac-00be652f40d9)

### User Profile Bloc Logic
```dart
class GetUserBloc extends Bloc<GetUserEvents, GetUserState>{

  final UserRepository userRepository;

  GetUserBloc({required this.userRepository}) : super(GetUserState.loading()){
    on<GetUserEvent>((event, emit) async{
      try{
        final UserModel user = await userRepository.getUser(event.uid);
        emit(GetUserState.success(user));
      }catch(e){
        print(e.toString());
        emit(GetUserState.failure());
      }
    });
  }
}
```

# CookVerse: Post Recipe

Introducing the "Post Recipe" feature, where you can share your culinary masterpieces with the CookVerse community. This feature empowers you to provide detailed information about your recipes, including ingredients, steps, cooking time, and even multimedia elements like images and tutorial videos.

## How to Post a Recipe

1. **Access the Post Recipe Page:**
   - Navigate to the bottom navigation bar and tap on the "Post Recipe" icon.

2. **Recipe Details:**
   - Fill in the essential details about your recipe:
     - **Recipe Title:** Choose a catchy and descriptive title.
     - **Ingredients:** List all the ingredients needed for your recipe.
     - **Cooking Steps:** Outline the step-by-step instructions to recreate your dish.
     - **Cooking Time:** Specify the approximate time required to prepare the dish.
       etc...

For complete information about the details check the following image.

![Screenshot_5](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/6a9782cf-7c49-4902-a190-a157c0ff46f7)    

4. **Add Multimedia Elements:**
   - Make your recipe stand out by adding visuals:
     - **Recipe Image:** Upload an enticing image of the finished dish.
     - **Tutorial Video:** Upload your craft's video.

5. **Submit Your Recipe:**
   - Tap the "Submit" button to share your culinary creation with the CookVerse community.

//Create post bloc for example

```dart
class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostsState>{

  final PostRepository postRepository;

  CreatePostBloc({required this.postRepository}) : super(CreatePostsState.initial()){
    on<CreatePostEvent>((event, emit) async{
      emit(CreatePostsState.loading());
      try{
        final Post post = await postRepository.createPost(event.post);
        emit(CreatePostsState.success(post));
      }catch(e){
        print(e.toString());
        emit(CreatePostsState.failure());
      }
    });
  }

}
```
//For image upload
```dart
ImagePicker picker = ImagePicker();
XFile? img = await picker.pickImage(
  source: ImageSource.gallery,
  maxHeight: 500,
  maxWidth: 500,
  imageQuality: 80
  );
if (img != null){
  updatePostBloc.add(UploadDishPicEvent(file: img.path, userId: userBloc.state.userModel.id, postId: post.id));
}
```

# CookVerse: Recipe Page

Explore the detailed world of culinary delights on the CookVerse Recipe Page. Dive into mouth-watering recipes contributed by chefs from around the globe. This page provides a rich experience, allowing users to view, interact, and connect with each recipe.

## Recipe Details

Discover a wealth of information about each recipe:

- **Recipe Image:** A visual feast, showcasing the finished dish.
- **Title:** A captivating title that sets the tone for the culinary journey.
- **Ingredients:** A list of carefully curated ingredients.
- **Cooking Steps:** Step-by-step instructions to recreate the dish.
- **Cooking Time:** The estimated time required to prepare the recipe.
- **Watch Tutorial:** Watch the tutorial video for the recipe.

  ![Screenshot_6](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/06971e86-ce68-4c7e-972d-04c81e1b3272)

## Interaction Features

### Like and Bookmark

Express your appreciation for a recipe by giving it a "Like." Bookmark recipes that catch your eye for future cooking adventures.

### User Profile Navigation

Click on the user's profile picture or name to navigate to their profile. Explore their culinary creations, followers, and followed chefs. Connect with fellow food enthusiasts and build a community of inspired chefs.

//Get Recipe info bloc
```dart
class PostUserBloc extends Bloc<PostUserEvents, PostUserStates>{

  final UserRepository userRepository;
  final PostRepository postRepository;

  PostUserBloc({required this.userRepository, required this.postRepository}) : super(PostUserStateInitial()){
    on<GetUserAndPostModelEvent>((event, emit) async{
      emit(GetUserAndPostState.loading());
      try{
        final UserModel user = await userRepository.getUser(event.uid);
        final Post post = await postRepository.getPost(event.pid);
        emit(GetUserAndPostState.success(user, post));
      }catch(e){
        print(e.toString());
        emit(GetUserAndPostState.failure());
      }
    });
  }

}
```
# CookVerse: User Page

Welcome to your personalized CookVerse User Page! This space empowers you to explore and engage with the global culinary community. Connect with other chefs, discover their recipes, and showcase your own contributions.

![Screenshot_7](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/35469290-6b33-472d-ae8b-e3ad9258dd90)


## Features

### Follow Other Users

- Explore the vibrant CookVerse community and follow other chefs to stay updated on their latest culinary creations.
- Build connections with like-minded individuals who share a passion for cooking.

### View Other Users' Recipes

- Browse through the recipes shared by chefs you follow, gaining inspiration from a diverse range of culinary styles.
- Discover new and exciting dishes from the talented CookVerse community.

//Follow Bloc Snippet
```dart
class FollowerBloc extends Bloc<FollowUnEvents, FollowUnState>{

  final UserRepository userRepository;

  FollowerBloc({required this.userRepository}) : super(FollowUnState.initial()){
    on<FollowUnRequestEvent>((event, emit) async{
      try{
        List<dynamic> mainList = await userRepository.followUnfollow(event.user, event.follower);
        if (mainList[1]){
          emit(FollowUnState.unfollow(mainList[0]));
        }else{
          emit(FollowUnState.follow(mainList[0]));
        }
      }catch(e){
        print(e.toString());
        emit(FollowUnState.failure());
      }
    });

    on<RestFollowBloc>((event, emit) {
      emit(FollowUnState.initial());
    });
  }

}
```
# CookVerse: Search Feature

Unlock the vast world of culinary inspiration with the CookVerse Search feature. Whether you're craving a specific dish or exploring new recipes, this feature allows you to effortlessly discover recipes that match your preferences.

![Screenshot_8](https://github.com/adityabhusari/Recipe_Social_media/assets/96617434/fa61d506-86e5-4e21-a26b-acf51af919d2)

## Features

### Recipe Search

- Search for recipes based on keywords, ingredients, or specific cuisines.
- Easily find and explore a wide range of culinary creations contributed by chefs from around the globe.

//Search Bloc Snippet
```dart
class SearchBloc extends Bloc<SearchEvents, SearchStates>{


  final PostRepository postRepository;

  SearchBloc({required this.postRepository}) : super(SearchInitialEvent()) {

    on<SearchEvent>((event, emit) async{
      try{
          List<Post> validPosts = [];
          final List<Post> postList = await postRepository.getPosts();
          for (Post post in postList){
            if (post.name!.toLowerCase()!.contains(event.word)){
              validPosts.add(post);
            }
          }
          emit(SearchSuccessState(validPosts: validPosts));
      }catch(e){
        print(e.toString());
        emit(SearchFailEvent());
      }
    });
  }

}
```
# Current Issues
The video player has not been working even after multiple attempts using assets and networkUrl mp4 files. Might be an permission issue from Firebase Storage as in a completely fresh project the asset mp4 files work correctly, pretty sure its arising due to firebase. Will update asap.
