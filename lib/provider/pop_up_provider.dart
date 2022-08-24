import 'package:flutter/material.dart';

class PopUpProvider extends ChangeNotifier{
	bool clicked = false;

	void setStatus(bool value){
		clicked = value;
		notifyListeners();
	}
	
	bool get getStatus => clicked;
  
}
