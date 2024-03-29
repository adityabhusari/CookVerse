import 'dart:ui';
// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DishTut extends StatefulWidget {
  final String dishTutUrl;

  const DishTut({super.key, required this.dishTutUrl});

  @override
  State<DishTut> createState() => _DishTutState();
}

class _DishTutState extends State<DishTut> {
  // late CustomVideoPlayerController _customVideoPlayerController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  void dispose() {
    // _customVideoPlayerController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: VideoPlayer(_videoPlayerController),
      // body: Stack(
      //     children: [
      //     Align(
      //     alignment: AlignmentDirectional(-1.6, -1.2),
      //       child: Container(
      //         height: width/1.5,
      //         width: width/1.5,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.grey.shade300,
      //         ),
      //       ),
      //     ),
      //     Align(
      //     alignment: AlignmentDirectional(3, 0),
      //       child: Container(
      //         height: width/1.5,
      //         width: width/1.5,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.blue.shade100,
      //         ),
      //       ),
      //     ),
      //     BackdropFilter(
      //       filter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
      //       child: Container(),
      //     ),
      //  ]
      // )
    );
  }

  void initializeVideoPlayer() {
    // final Uri videoUrl = Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    // VideoPlayerController _videoPlayerController;
    _videoPlayerController = VideoPlayerController.asset('assets/RL.mp4')..
    initialize().
    then((value) {
      setState(() {});
    });

    // _customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: _videoPlayerController);
  }
}
