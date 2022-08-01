import 'package:app_delivery_udemy/src/models/product.dart';
import 'package:flutter/material.dart';

class ClienteProductsDetailController {

  BuildContext context;
  Function refresh;

  Product product;

  Future init(BuildContext context, Function refresh, Product product) {
    this.context = context;
    this.refresh = refresh;
    this.product = product;

    refresh();
  }

}