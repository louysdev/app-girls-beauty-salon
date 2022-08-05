import 'package:app_delivery_udemy/src/models/address.dart';
import 'package:app_delivery_udemy/src/models/user.dart';
import 'package:app_delivery_udemy/src/provider/address_provider.dart';
import 'package:app_delivery_udemy/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientAddressListController {

  BuildContext context;
  Function refresh;

  List<Address> address = [];
  AddressProvider _addressProvider = new AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  int radioValue = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    
    _addressProvider.init(context, user);
  }

  void handleRadioValueChange(int value) {
    radioValue = value;
    refresh();
    print('Valor seleccionado: ${radioValue}');
  }

  void goToNewAddress() {
    Navigator.pushNamed(context, 'client/address/create');
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);
    return address;
  }

}