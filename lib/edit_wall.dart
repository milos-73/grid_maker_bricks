import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_list.dart';
import 'edit_wall_tiles.dart';
import 'list_of_walls.dart';

class EditWall extends StatefulWidget {

  final int? wallNumber;

  const EditWall({super.key, this.wallNumber});

  @override
  State<EditWall> createState() => _EditWallState();
}

BrickWalls brickWalls = BrickWalls();

List? colorsNumbers;

List colorNumbersReset =
[
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
];

bool? reset = false;

class _EditWallState extends State<EditWall> {

  Future<List?> getWallColors(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    colorsNumbers = jsonDecode(prefs.getString('wall$wallNumber') ?? '');

    //reset = false;

    return colorsNumbers;
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Edit Wall'),
        leading: IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ListWalls()));} , icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future:  getWallColors(widget.wallNumber),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                if (snapshot.hasData) {
                  brickWalls.updateEditedList(colorsNumbers);
                  return SizedBox (height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 220,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                      itemBuilder: (context, index) => EditWallTile(wallNumber: widget.wallNumber, index: index, colorNumber:
                      (colorsNumbers?[(index / 11).floor()][index % 11]) !=0
                      ? ((colorsNumbers?[(index / 11).floor()][index % 11]) -10)
                      : 0,
                    ),
                    )
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },

            ),


            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox (height: MediaQuery.of(context).size.height * 0.20,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 73,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                    itemBuilder: (context, index) => ColorList(index),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20, bottom: 15, top: 10),
              child: SizedBox(width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 130, height: 40,
                          child: ElevatedButton(onPressed: (){
                            brickWalls.saveEditedWallAsNew();},style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ), child: const Text('Save as new'),),
                        ),

                        SizedBox(width: 130, height: 40,
                          child: ElevatedButton(onPressed: (){
                            brickWalls.saveEditedWall(widget.wallNumber!);},style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ), child: const Text('Save'),),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 130, height: 40,
                          child: ElevatedButton(onPressed: (){


                            setState(() {
                              colorsNumbers = colorNumbersReset;

                            });

                          },

                            style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ), child: const Text('Reset'),),
                        ),
                        SizedBox(width: 130, height: 40,
                          child: ElevatedButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ListWalls()));
                          },style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ), child: const Text('Cancel'),),
                        ),
                      ],
                    ),

                  ],

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
