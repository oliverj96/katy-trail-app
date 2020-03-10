import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Audio extends StatelessWidget {
static AudioPlayer audioPlayer = AudioPlayer();

  static int play = 0;

  void playAudio() async {
    audioPlayer = await AudioCache().play("songExample.mp3");
  }

  void stopAudio() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: <Widget>[
            IconButton(
              iconSize: 50.0,
              icon: Icon(
                Icons.play_circle_filled, 
                color: Colors.blueGrey,
              ),
              onPressed: (){
                if(play % 2 == 0){ 
                  playAudio();
                  play++;
                } else {
                  stopAudio();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}