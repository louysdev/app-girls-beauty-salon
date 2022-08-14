import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

class ClientPaymentsCreateController {

  BuildContext context;
  Function refresh;
  GlobalKey<FormState> KeyForm = new GlobalKey();

  String cardNumber = "";
  String expireDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool isCvvFocuses = false;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expireDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocuses = creditCardModel.isCvvFocused;
    refresh();
  }

}