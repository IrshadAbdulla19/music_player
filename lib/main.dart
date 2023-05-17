import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

import 'package:music_player/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userIn = 'for show';
const userCheck = 'for check';
Future<void> main() async {
  await Hive.initFlutter();
  // await createHiveBoxes();
  if (!Hive.isAdapterRegistered(AllSongsListsAdapter().typeId)) {
    Hive.registerAdapter(AllSongsListsAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  await Hive.openBox<AllSongsLists>('allsong');
  await Hive.openBox<PlayListModel>('playlist_db');

  runApp(MyApp());
  SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

Future<void> createHiveBoxes() async {
  // await Hive.openBox<FavouriteSongsModel>('favsongs');
  await Hive.openBox<AllSongsLists>('allsong');
}
