import 'package:eagles_customer_app/globals/firebase_variables.dart';
import 'package:eagles_customer_app/userApp/premium/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../homepage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  getVideos() {}

  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId('https://youtu.be/ORDjs-oHJ5Q')!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: true,
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          color: Colors.red,
          child: ListView(
            children: [
              ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Container(
                      color: Colors.yellow,
                      height: h * 0.3,
                      child: Column(
                        children: [
                          Container(
                              color: Colors.black,
                              height: h * 0.2,
                              width: w,
                              child: SvgPicture.asset('assets/leader.svg')),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FullScreen(),
                                  ));
                            },
                            child: Container(
                                color: Colors.green,
                                height: h * 0.1,
                                width: w,
                                child: Text('Basic and fundamental of ...')
                                // child: YoutubePlayer(
                                //   controller: _controller,
                                //   showVideoProgressIndicator: true,
                                //   progressIndicatorColor: Colors.red,
                                // ),
                                ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
