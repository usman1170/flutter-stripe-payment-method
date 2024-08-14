import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payments/utils/consts.dart';

class StripeService {
  StripeService._();
  static final StripeService stripeService = StripeService._();

  Future<void> makePayment() async {
    try {
      String? clientSecret = await _createPaymentIntent(10, "usd");
      if (clientSecret == null) {
        return;
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "SyncEX",
        ),
      );
      await _prossessPayment();
    } on StripeError catch (e) {
      if (e.code == FailureCode.Canceled) {
        log("Payment Cencelled");
      }
    } catch (e) {
      log("Error in makePayment = ${e.toString()}");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        intentUrl,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );
      if (response.data != null) {
        log(response.data.toString());
        log(response.data["client_secret"].toString());
        return response.data["client_secret"];
      } else {
        return null;
      }
    } catch (e) {
      log("Error in Intent = ${e.toString()}");
    }
    return null;
  }

  Future<void> _prossessPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } on StripeError catch (e) {
      if (e.code == "FailureCode.Canceled") {
        log("Payment Cencelled");
      }
    } catch (e) {
      log("Error on prossess payment = ${e.toString()}");
    }
  }

  String _calculateAmmount(int ammount) {
    final calculatedAmt = ammount * 100;
    return calculatedAmt.toString();
  }
}
