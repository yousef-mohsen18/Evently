import 'package:evently_task/core/remote/Network/fire_store_manager.dart';
import 'package:flutter/cupertino.dart';

import '../model/fire_store/User.dart';

class UserProvider extends ChangeNotifier{

  User? user;

  setUserValue()async{
    user=await FireStoreManager.getUserData();
    notifyListeners();
  }

}