import 'package:flutter/material.dart';
import 'package:music_app/components/neo_box.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  const Songpage({super.key});

  // Convert duration into mm:ss
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String formatTime(Duration duration) {
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<playlistProvider>(
      builder: (context, value, child) {
        // Get playlist
        final playlist = value.playlist;

        // Get current song index
        final currentsong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 1, left: 25),
              child: Column(
                children: [
                  // App bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text('P L A Y L I S T'),
                      IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                    ],
                  ),

                  SizedBox(height: 25),

                  // album artwork
                  NeoBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentsong.albumArtImagePath),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    currentsong.artisName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(currentsong.songName),
                                ],
                              ),
                              Icon(Icons.favorite, color: Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  // Song duration progress
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(value.currentDuration)),
                            Icon(Icons.shuffle),
                            Icon(Icons.repeat),
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                      ),

                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          )
                        ),
                        child: Slider(
                          min: 0,
                        
                          // Protect slider from errors
                          max: value.totalDuration.inSeconds == 0
                              ? 1
                              : value.totalDuration.inSeconds.toDouble(),
                        
                          value: value.currentDuration.inSeconds
                              .clamp(0, value.totalDuration.inSeconds)
                              .toDouble(),
                        
                          activeColor: Colors.green,
                          secondaryTrackValue: 1,
                        
                          onChanged: (newValue) {},
                        
                          onChangeEnd: (newValue) {
                            value.seek(Duration(seconds: newValue.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Playback controls
                  Row(
                    children: [
                      // Skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviouseSong,
                          child: NeoBox(child: Icon(Icons.skip_previous)),
                        ),
                      ),

                      SizedBox(width: 20),

                      // Play / Pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.puseOrResume,
                          child: NeoBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 20),

                      // Skip next
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeoBox(child: Icon(Icons.skip_next)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
