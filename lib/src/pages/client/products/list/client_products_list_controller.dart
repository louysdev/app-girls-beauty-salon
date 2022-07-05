import 'package:app_delivery_udemy/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientProductListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context){
    this.context = context;
  }

  logout() {
    _sharedPref.logout(context);
  }

}