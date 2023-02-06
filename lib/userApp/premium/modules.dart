import 'package:eagles_customer_app/userApp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({Key? key}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId('https://youtu.be/ORDjs-oHJ5Q')!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          forceHD: true,
          mute: false,
        ));

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        // height: h,
        // width: double.infinity,
        child:
            // YoutubePlayerBuilder(
            //   builder: (context, player) {
            //     return Column(
            //       children: [player],
            //     );
            //   },
            //   player:
            YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
    // );
  }
}
