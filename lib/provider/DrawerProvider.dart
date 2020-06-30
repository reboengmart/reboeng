import 'package:flutter/foundation.dart';

class DrawerProvider with ChangeNotifier{

  bool _isOpen = false;
  double _x = 0;
  double _y = 0;
  double _scale = 1;

  bool get isOpen => _isOpen;
  double get x => _x;
  double get y => _y;
  double get scale => _scale;

  set drawerState(bool isOpen){
    _isOpen = isOpen;
    notifyListeners();
    if (_isOpen) {
      _x = 230;
      _y = 150;
      _scale = 0.6;
    }else if (!_isOpen) {
      _x = 0;
      _y = 0;
      _scale = 1;
    }
  }

}