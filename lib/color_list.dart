import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_maker_bricks/hex_color.dart';
import 'package:grid_maker_bricks/provider_color.dart';
import 'package:provider/provider.dart';

import 'color_numbers.dart';

class ColorList extends StatefulWidget {
  final int indexNo;

  const ColorList(
      this.indexNo, {super.key});

  @override
  State<ColorList> createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {

  int? activeColor = 0;
  ColorNumbers colorNumbers = ColorNumbers();

  void setColor(int index){

      setState(() {
        activeColor = index;
      });
      Provider.of<BrickColorNumber>(context,listen: false).setBrickColor(index);


   }

  @override
  Widget build(BuildContext context) {
     return ListTile(
      tileColor: (widget.indexNo) < 77 ? HexColor(colorNumbers.getColor(widget.indexNo)) : HexColor(colorNumbers.getColor((widget.indexNo) + 7)),
      onTap: () {

        if ((widget.indexNo) < 77){setColor(widget.indexNo);print('${widget.indexNo}');} else {setColor((widget.indexNo) + 7);print('${widget.indexNo+7}');}}

        //(widget.indexNo) < 77 ? setColor(widget.indexNo) : setColor((widget.indexNo) + 7);},

    );
  }
}