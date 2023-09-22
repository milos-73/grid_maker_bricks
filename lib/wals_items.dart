import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_numbers.dart';
import 'created_wall_builder.dart';


class WallsItems extends StatefulWidget {

  final int? wallNumber;

  const WallsItems({super.key, this.wallNumber});

  @override
  State<WallsItems> createState() => _WallsItemsState();
}

List? wall;

class _WallsItemsState extends State<WallsItems> {



  getWalldata(int? wallNumber) async {

    print(widget.wallNumber);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print (prefs.getString('wall2'));
    wall = jsonDecode(prefs.getString('wall${widget.wallNumber}') ?? '');
    print('getWALLData${widget.wallNumber}');
    return wall;
  }

  @override
  void initState() {
    super.initState();
    //getWalldata(widget.wallNumber).then((value) => setState(() {wall = value;}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWalldata(wallNumber),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

    if (snapshot.hasData) {
      print('SNAPSHOT: ${snapshot.data}');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 220,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                itemBuilder: (context, index) => CreatedWallBuilder(index, snapshot.data),
              ),
            );
          } else {
      return const CircularProgressIndicator();
    }
        },
             ),
    );
}
}
