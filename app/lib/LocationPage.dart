import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import './TextSection.dart';
import './TitleSection.dart';
import './AboutImage.dart';

class LocationPage extends StatelessWidget {

  static AudioPlayer audioPlayer = AudioPlayer();

  bool audioIsPlaying = true; 

  void playAudio() async {
    audioPlayer = await AudioCache().play("songExample.mp3");
    audioIsPlaying = true; 
  }

  bool isPlaying(bool play){
    return play; 
  }

  void stopAudio() async {
    await AudioPlayer().stop();
    audioIsPlaying = false; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: new AppBar(title: Text("Location"),
        actions: <Widget>[ 
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new LocationPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        
        child: ListView(
          children: <Widget>[
            IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            onPressed: (){
              if(isPlaying(audioIsPlaying)) {
                stopAudio();
              } else {
                playAudio(); 
              }
            },
          ),
            //TitleSection(),
            //AboutImage(),
            //TextSection(),
            //TextSection(),
            //TextSection(),
          ],
          
        ), 
      ),
    );
  }
}
