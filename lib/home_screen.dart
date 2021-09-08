// @dart=2.9
import 'dart:io';

import 'package:beatflys/MusicPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  int currentIndex = 0;
  final GlobalKey<MusicPlayerScreenState> key=GlobalKey<MusicPlayerScreenState>();

  void initState() {
    super.initState();
    getTracks();
  }

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void changeTrack(bool isNext){
    if(isNext){
      if(currentIndex!=songs.length-1){
        currentIndex++;
      }
    }else{
      if(currentIndex!=0){
        currentIndex--;
      }
    }
    key.currentState.setSong(songs[currentIndex]);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xff0B1444),
            Color(0xaaFFFFFF),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "HOME",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                    Color(0xff1FB2E0),
                Color(0xaaFFFFFF),
                ]
                ),

              ),

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(40),
                  color: Color(0xff1FB2E0),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color(0xff0B1444),
                    size: 30,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0B1444),
                      fontSize: 30,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xff0B1444),
                    thickness: 6,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.featured_play_list,
                    color: Color(0xff0B1444),
                    size: 30,
                  ),
                  title: Text(
                    'Playlist',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0B1444),
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xff0B1444),
                    thickness: 6,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Color(0xff0B1444),
                    size: 30,
                  ),
                  title: Text(
                    'Favourites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0B1444),
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xff0B1444),
                    thickness: 6,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Color(0xff0B1444),
                    size: 30,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0B1444),
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xff0B1444),
                    thickness: 6,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xff0B1444),
                    size: 30,
                  ),
                  title: Text(
                    'Exit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0B1444),
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 50, 10),
          child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (BuildContext context, int index) {
                if(songs[index].filePath.contains("mp3"))
                return Card(
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          currentIndex = index;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MusicPlayerScreen(
                                  changeTrack:changeTrack,songInfo: songs[currentIndex],key: key,)));
                        },
                        child: ListTile(
                          tileColor: Color(0xcc6C6C6C),
                          leading: CircleAvatar(
                            backgroundImage: songs[index].albumArtwork == null
                                ? AssetImage('assets/download.png')
                                : FileImage(File(songs[index].albumArtwork)),
                          ),
                          title: Text(
                            songs[index].title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          subtitle: Text(songs[index].artist),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.playlist_add,
                                      size: 30,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_border))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                return Container(
                  height: 0,
                );
              }),
        ),
      ),
    );
  }
}
