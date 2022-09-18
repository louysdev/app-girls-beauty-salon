import 'dart:convert';

import 'package:app_girls_beauty_salon/src/models/stripe_transaction_response.dart';
import 'package:app_girls_beauty_salon/src/utils/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeProvider {

  String secret = 'sk_test_51LWocvJqQu6wsQ39U02vkLU3hZj4O2FROrHBUE76Wmv88JiJ0yukieKoz4DiN7XoYbKmlJGSoma6xwYePQuKZpnG00OAmBjkav';
  Map<String, String> headers = {
    'Authorization': 'Bearer sk_test_51LWocvJqQu6wsQ39U02vkLU3hZj4O2FROrHBUE76Wmv88JiJ0yukieKoz4DiN7XoYbKmlJGSoma6xwYePQuKZpnG00OAmBjkav',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  BuildContext context;

  void init(BuildContext context) {
    this.context = context;
    StripePayment.setOptions(StripeOptions(
        publishableKey: 'pk_test_51LWocvJqQu6wsQ39TfgCwwgTFOjGOjcmzyIMCUNuOfzfYYxiwKw0lglEK22AePQyld4ETkIGJN2YakHnHYtF9DdI00RYO6LxWs',
        merchantId: 'test',
        androidPayMode: 'test'
    ));
  }

  Future<StripeTransactionResponse> payWithCard(String amount, String currency) async {

    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
      var paymentIntent = await createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id
      ));

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaccion exitosa',
          succes: true,
          paymentMethod: paymentMethod
        );
      }
      else {
        return new StripeTransactionResponse(
            message: 'Transaccion Fallo',
            succes: false
        );
      }
    } catch (e) {
      print('Error al realizar la transaccion $e');
      MySnackbar.show(context, 'Error al realizar la transaccion $e');
      return null;
    }

  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {

    try {
      Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card'
      };
      
      Uri uri = Uri.https('api.stripe.com', 'v1/payment_intents');
      var respone = await http.post(uri, body: body, headers: headers);
      return jsonDecode(respone.body);

    } catch (e) {
      print('Error al crear el intent de pagos $e');
      return null;
    }

  }

}