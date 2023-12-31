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

List indexList = [5,16,27,38,49,60,71,82,93,104,115,126,137,148,159,170,181,192,203,214,99,100,101,102,103,105,106,107,108,109,110,111,112,113,114,116,117,118,119,120];
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

    return
      _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && !indexList.contains(widget.itemNo)
      ? ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),tileColor: HexColor('#d6d6d4'), onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},)
      : _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && indexList.contains(widget.itemNo)
      ? ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),tileColor: HexColor('#cececc'), onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},)
      : Provider.of<BrickColorNumber>(context, listen: false).index == 84
      ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak1.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 85
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak2.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 86
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak3.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 87
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak4.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 88
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/noBreak5.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},))
          : Provider.of<BrickColorNumber>(context, listen: false).index == 90
          ? Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/crackedBrick.png'),fit: BoxFit.fill)), child: ListTile(onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},))
      : ListTile(shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),tileColor: HexColor(colorNumbers.getColor(Provider.of<BrickColorNumber>(context, listen: false).index ?? 0)),onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},);


  }

  ListTile listTileNormal(BuildContext context) {
    return ListTile(
    shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.black26,width: 0)),
    tileColor: _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && !indexList.contains(widget.itemNo)
        ? HexColor('#d6d6d4')
        : _color == true && Provider.of<BrickColorNumber>(context, listen: false).index == 0 && indexList.contains(widget.itemNo)
        ? HexColor('#cececc')
        : HexColor(colorNumbers.getColor(Provider.of<BrickColorNumber>(context, listen: false).index ?? 0)),
    onTap: () {setState(() {_color = !_color!;});brickWalls.addBrickTypeToList(context, widget.itemNo);brickWalls.countNumberOfBricks(context);},
  );
  }
}