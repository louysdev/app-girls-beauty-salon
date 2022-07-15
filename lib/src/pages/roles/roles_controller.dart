import 'package:app_delivery_udemy/src/models/user.dart';
import 'package:app_delivery_udemy/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class RolesController{

  BuildContext context;
  Function refresh;
  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;

    // Obteniendo usuario de sesion
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
  }


  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

}