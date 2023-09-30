import 'package:flutter/foundation.dart';

class BrickColorNumber extends ChangeNotifier {
  int? index = 0;
  int bricksCount = 0;
  int bricksEditedWallCount = 0;

  void setBrickColor(int? value,) {
    index = value;

    notifyListeners();
  }

  void countBricks(int value,) {
    bricksCount = value;

    notifyListeners();
  }

  void countBricksOnEditedWall(int value,) {
    bricksCount = value;

    notifyListeners();
  }

}