import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool succes;
  PaymentMethod paymentMethod;

  StripeTransactionResponse({this.message, this.succes, this.paymentMethod});


}