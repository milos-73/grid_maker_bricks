import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/wals_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWalls extends StatefulWidget {

  const ListWalls({super.key});

  @override
  State<ListWalls> createState() => _ListWallsState();
}

class _ListWallsState extends State<ListWalls> {
  SharedPreferences? prefs;
  int? wallsCount;

  Future<void> loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

 Future<void> wallsCountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? count = prefs.getInt('wallNumber');
   setState(() {
     wallsCount = count;
   });

  }

  @override
  void initState() {
    super.initState();
    wallsCountNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: wallsCount,
          itemBuilder:(context,index){
            return SizedBox(height:MediaQuery.of(context).size.height * 0.25,
                child: WallsItems(wallNumber: index));
          }
      )
      );

  }
}
