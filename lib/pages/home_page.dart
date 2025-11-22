 import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/models/songpage.dart';
import 'package:provider/provider.dart';

 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the playlist provider
  late final dynamic playlistprovider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    playlistprovider = Provider.of<playlistProvider>(context, listen: false);

    
  }
         // go to a song
     void goToSong(int songIndex) {
    playlistprovider.currentSongIndex = songIndex;

    //navigate to song

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Songpage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.background,
      appBar: AppBar( title:  Text(" P L A Y L I S T"),
      ),
      drawer: MyDrawer(),

      body: Consumer<playlistProvider>(
        builder: (context, value, child) {
          // get playlist
          final List<Song> playlist =value.playlist;


          return ListView.builder(
            itemCount:playlist.length ,
            itemBuilder: (context, index) {
              // get individual song

              final Song song = playlist[index];

              // return list tile ui
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artisName),
                leading: Image.asset(song.albumArtImagePath),
                 onTap: () => goToSong(index),
              

              );


            }

            );
        }
        
        
        ),
    );
  }
}