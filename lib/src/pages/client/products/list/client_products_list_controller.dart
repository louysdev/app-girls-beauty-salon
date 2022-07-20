import 'package:app_delivery_udemy/src/models/category.dart';
import 'package:app_delivery_udemy/src/models/user.dart';
import 'package:app_delivery_udemy/src/provider/categories_provider.dart';
import 'package:app_delivery_udemy/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientProductListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;

  User user;

  List<Category> categories = [];
  CategoriesProvider _categoriesProvider = new CategoriesProvider();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    getCategories();
    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }
  
  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

}