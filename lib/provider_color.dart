import 'package:flutter/foundation.dart';

class BrickColorNumber extends ChangeNotifier {
  int? index = 0;
  int bricksCount = 0;

  void setBrickColor(int? value,) {
    index = value;

    notifyListeners();
  }

  void countBricks(int value,) {
    bricksCount = value;

    print('NUMBER: $value');

    notifyListeners();
  }

}