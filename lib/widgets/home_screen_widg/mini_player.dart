import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/library_functions/most_played.dart';
import 'package:music_player/functions/library_functions/resent_played.dart';
import 'package:music_player/screens/current_play_screen.dart';

import 'package:music_player/styles/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlaying = true;

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   audioPlayer.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (cntx, playing) {
      resentPlyed(int.parse(playing.audio.audio.metas.id!));

      mostPlayAdd(int.parse(playing.audio.audio.metas.id!));
      return GestureDetector(
          onTap: () {
            AllSongsLists song =
                changeToSongModel(int.parse(playing.audio.audio.metas.id!));
            Navigator.push(context, MaterialPageRoute(builder: (cntx) {
              return CurrentPlayScreen(
                song: song,
              );
            }));
          },
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: QueryArtworkWidget(
                          id: int.parse(playing.audio.audio.metas.id!),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Image.asset(
                            'asset/images/songe_screen.png',
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: TextScroll(
                            playing.audio.audio.metas.title!,
                            velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                            pauseBetween: Duration(milliseconds: 1000),
                            style: songNameText,
                          ),
                        ),
                      ],
                    ),
                    // subtitle: Text('artist'),
                    subtitle: Wrap(
                      children: [
                        IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.skip_previous_rounded)),
                        IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                audioPlayer.pause();
                                setState(() {
                                  isPlaying = false;
                                });
                              } else {
                                audioPlayer.play();
                                setState(() {
                                  isPlaying = true;
                                });
                              }
                            },
                            // iconSize: 30,
                            color: Colors.white,
                            icon: isPlaying
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow)),
                        IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.skip_next_rounded)),
                        IconButton(
                            onPressed: () {
                              audioPlayer.stop();
                              setState(() {
                                isPlaying = false;
                                isSongPlayingNotifier.value = isPlaying;
                                isSongPlayingNotifier.notifyListeners();
                              });
                            },
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.stop)),
                      ],
                    ),
                  )),
            ),
          ));
    });
  }
}

AllSongsLists changeToSongModel(int songId) {
  late AllSongsLists data;
  for (var element in AllSongsNotifier.value) {
    if (element.songID == songId) {
      data = element;
      break;
    }
  }
  return data;
}
