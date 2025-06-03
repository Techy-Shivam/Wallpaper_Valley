import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import 'package:wallpaper_app/views/screens/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Start playing the video
      });

    // Set a timer to navigate to the next screen after 4 seconds
    Timer(const Duration(seconds: 4 ), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();  // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              fit: StackFit.expand,  // Make sure the video fills the entire screen
              children: [
                FittedBox(
                  fit: BoxFit.cover,  // Cover the entire screen with the video
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()), // Loading indicator
    );
  }
}
