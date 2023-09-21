
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:grid_maker_bricks/walls.dart';
import 'package:provider/provider.dart';

import 'color_numbers.dart';

class ItemTile extends StatefulWidget {
  final int itemNo;

  const ItemTile(this.itemNo, {super.key});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {

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
      tileColor: _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 ? HexColor('#d6d6d4') : HexColor(colorNumbers.getColor(Provider.of<BrickColorNumber>(context, listen: false).index ?? 0)),
      onTap: () {
      setState(() {_color = !_color!;});
      brickWalls.addBrickTypeToList(context, widget.itemNo);
        },
        );
  }
}