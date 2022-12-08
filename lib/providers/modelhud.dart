

import 'package:flutter/material.dart';

class ModelHud extends ChangeNotifier
{
  bool isLoading =false;

  changeisLoading(bool value)
  {
    isLoading=value;
    notifyListeners();
  }
}