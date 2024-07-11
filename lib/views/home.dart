import 'package:beats/consts/colors.dart';
import 'package:beats/consts/text_style.dart';
import 'package:beats/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: whiteColor))
          ],
          leading: const Icon(Icons.sort_rounded, color: whiteColor),
          title: Text("Beats", style: ourStyle(family: bold, size: 18)),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "not found",
                    style: ourStyle(),
                  ),
                );
              }
              else{
                return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ListTile(
                tileColor: bgColor,
                title: Text(
                  snapshot.data![index].displayNameWOExt,
                  style: ourStyle(family: bold, size: 15),
                ),
                subtitle: Text(
                  "${snapshot.data![index].artist}",
                  style: ourStyle(family: regular, size: 12),
                ),
                leading: const Icon(
                  Icons.music_note,
                  color: whiteColor,
                  size: 32,
                ),
                trailing: const Icon(
                  Icons.play_arrow,
                  color: whiteColor,
                  size: 26,
                ),
              ),
            );
          },
        ),
      );
              }  
            }
            ));
  }
}
