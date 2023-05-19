import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'classification_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Music_card extends StatefulWidget {
  //const Music_card({Key? key}) : super(key: key);
  String myGrouping;
  Music_card({required this.myGrouping});

  @override
  State<Music_card> createState() => _Music_cardState(myGrouping);
}

class _Music_cardState extends State<Music_card> {
  final db = FirebaseFirestore.instance;
  //String stop = Classification_screen().myGrouping;
  String myGrouping;
  _Music_cardState(this.myGrouping);

  @override
  void didUpdateWidget(Music_card oldWidget) {
    if (myGrouping != widget.myGrouping) {
      setState(() {
        myGrouping = widget.myGrouping;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  int no_of_cards = 3;

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('music_data')
              .where('grouping', isEqualTo: myGrouping)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  String selectedUrl = doc["url"];
                  String videoId;

                  videoId = YoutubePlayer.convertUrlToId(selectedUrl)!;
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: true,
                    ),
                  );

                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            //height: 500,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7)
                                ]),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        doc["song_title"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(" - "),
                                      Text(
                                        doc["artist_name"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    doc["year"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: YoutubePlayer(
                                      controller: _controller,
                                      //thumbnail: Image.network(doc["url"]),
                                      liveUIColor: Colors.amber,
                                    ),
                                    //height: MediaQuery.of(context).size.width,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                                height: 45,
                                width: 45,
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.white, // button color
                                    child: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: IconButton(
                                        icon: Icon(selected
                                            ? Icons.favorite_border_outlined
                                            : Icons.favorite),
                                        color: Colors.amber,
                                        onPressed: () {
                                          setState(() {
                                            selected = !selected;
                                          });
                                        },
                                      ), //IconButton
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }

            //  }
          }),
    );
  }
}
