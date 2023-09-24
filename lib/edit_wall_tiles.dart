import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_numbers.dart';
import 'hex_color.dart';

class EditWallTile extends StatefulWidget {

  final int? wallNumber;
  final int index;
  final int? colorNumber;

  const EditWallTile({this.wallNumber,super.key, required this.index, this.colorNumber});

  @override
  State<EditWallTile> createState() => _EditWallTileState();
}

class _EditWallTileState extends State<EditWallTile> {

  ColorNumbers colorNumbers = ColorNumbers();
  bool? _color;
  BrickWalls brickWalls = BrickWalls();

 @override
  void initState() {
    super.initState();
    _color = true;
  }

  @override
  Widget build(BuildContext context) {

    return ListTile(
      shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black,width: 0.2)),
      tileColor: _color == true ? HexColor(colorNumbers.getColor(widget.colorNumber!)) : HexColor(colorNumbers.getColor(Provider.of<BrickColorNumber>(context, listen: false).index ?? 0)),

      onTap: () {
        setState(() {_color = !_color!;});
        brickWalls.addEditedBrickTypeToList(context, widget.index);
      },
    );
  }
}
