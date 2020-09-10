import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/History.dart';

class HistoryNotifier extends ChangeNotifier{
  List<History> _historyList=[];
  History _currentHistory;

  UnmodifiableListView<History> get historyList=>UnmodifiableListView(_historyList);
  History get currentHistory=>_currentHistory;
  set historyList(List<History> historyList){
    _historyList=historyList;
    notifyListeners();
  }
  set currentHistory(History history){
    _currentHistory=history;
    notifyListeners();
  }
}