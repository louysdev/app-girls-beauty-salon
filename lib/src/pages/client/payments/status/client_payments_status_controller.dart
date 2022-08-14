import 'package:flutter/material.dart';

class ClientPaymentsStatusController {

  BuildContext context;
  Function refresh;

  String brandCard = '';
  String last4 = '';

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;

    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    brandCard = arguments['brand'];
    last4 = arguments['last4'];

    refresh();
  }

  void finishShopping() {
    Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
  }

}