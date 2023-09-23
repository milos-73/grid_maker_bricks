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
import 'grid_items.dart';
import 'list_of_walls.dart';

class EditWall extends StatefulWidget {

  final int? wallNumber;

  const EditWall({super.key, this.wallNumber});

  @override
  State<EditWall> createState() => _EditWallState();
}

BrickWalls brickWalls = BrickWalls();

List? colorsNumbers;

class _EditWallState extends State<EditWall> {

  Future<List?> getWallColors(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    colorsNumbers = jsonDecode(prefs.getString('wall$wallNumber') ?? '');
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
              future: getWallColors(widget.wallNumber),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                if (snapshot.hasData) {
                  brickWalls.updateEditedList(colorsNumbers);
                  return SizedBox (height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 220,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                      itemBuilder: (context, index) => EditWallTile(wallNumber: 1, index: index, colorNumber:
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
                SizedBox (height: MediaQuery.of(context).size.height * 0.25,
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
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(width: 100, height: 40,
                      child: ElevatedButton(onPressed: (){
                        Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(0);
                        setState(() {});
                        brickWalls.resetWall();
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ), child: const Text('Reset'),),
                    )],),
                  Column(children: [
                    SizedBox(width: 100, height: 40,
                      child: ElevatedButton(onPressed: (){
                        brickWalls.saveEditedWall(widget.wallNumber!);},style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ), child: const Text('Save'),),
                    )
                  ],)
                ],),
            )
          ],
        ),
      ),
    );
  }
}
