import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoController {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  VideoController(String url) {
    _controller = VideoPlayerController.network(url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0);
    _controller.play();
  }

  Future<void> getIntitializeVideoPlayerFuture() {
    return _initializeVideoPlayerFuture;
  }

  FutureBuilder setVideoPlayer () {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue,
              ),
            );
          }
        }
    );
  }
}