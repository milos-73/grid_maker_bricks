import 'dart:convert';

import 'package:grid_maker_bricks/provider_color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


List brickList =
  [
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 25, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
    [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00],
 ];

 int? wallNumber;


class BrickWalls {


  Future<void> addBrickTypeToList(context, int index) async {

    int? row;
    int? column;
    int? color;
    int? wallNumber;

    column = (index % 11);
    row = (index / 11).floor();

    print('$index $row $column');

    color = (Provider.of<BrickColorNumber>(context, listen: false).index);
    color != null ? color = color + 10 : color = 0;

    brickList[row][column] = color;

  }

  Future<void> saveWall() async {

    var prefs = await SharedPreferences.getInstance();
    wallNumber = prefs.getInt('wallNumber') ?? 0;
    prefs.setString('wall$wallNumber', jsonEncode(brickList));
    prefs.setInt('wallNumber', wallNumber! + 1);
    jsonDecode(prefs.getString('wall$wallNumber') ?? '');

  }

}