import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_numbers.dart';
import 'created_wall_builder.dart';
import 'edit_wall.dart';


class WallsItems extends StatefulWidget {

  final int? wallNumber;

  const WallsItems({super.key, this.wallNumber});

  @override
  State<WallsItems> createState() => _WallsItemsState();
}

List? wall;

class _WallsItemsState extends State<WallsItems> {

  getWallData(int? wallNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    wall = jsonDecode(prefs.getString('wall${widget.wallNumber}') ?? '');
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
        future: getWallData(wallNumber),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

    if (snapshot.hasData) {
            return Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width,
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: SizedBox(width: MediaQuery.of(context).size.width * 0.47,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 220,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11, childAspectRatio: 2),
                            itemBuilder: (context, index) => CreatedWallBuilder(index, snapshot.data),
                          ),
                        ),
                      ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.40,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ElevatedButton(onPressed: () { Provider.of<BrickColorNumber>(context, listen: false).index = 0; Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditWall(wallNumber: widget.wallNumber))); },style: ElevatedButton.styleFrom(backgroundColor: Colors.green) ,child: const Text('Edit'),),
            //ElevatedButton(onPressed: () {  },style: ElevatedButton.styleFrom(backgroundColor: Colors.amber) ,child: const Text('Delete'),),
            ],
          ),
          ),
                    ],
                  ),
                ),
              ],
            );
          } else {
      return const CircularProgressIndicator();
    }
        },
             ),
    );
}
}
