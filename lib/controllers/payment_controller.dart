


import 'dart:convert';

import 'package:autorevive/services/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../env/config.dart';
import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';


class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  PaymentController() {
    Stripe.publishableKey = Config.publishableKey;
  }

  Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async {
    try {
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);
      if (kDebugMode) {
        print("Payment Intent: $paymentIntent");
      }
      return paymentIntent;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching payment intent: $e');
      }
      rethrow;
    }
  }

  Future<void> makePayment({required String price}) async {
    try {
      paymentIntentData = await createPaymentIntent(price, "USD");
      if (paymentIntentData != null) {
        String clientSecret = paymentIntentData!['client_secret'];

        if (kDebugMode) {
          print("Client Secret: $clientSecret");
        }

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: const BillingDetails(
              name: '',
              email: 'jaimulislam7@gmail.com',
            ),
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
            merchantDisplayName: 'jaimul islam',
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.dark,
          ),
        );

        displayPaymentSheet(price: price);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e\nStack trace: $s');
      }
    }
  }


  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${Config.secretKey}', // Use sk_test_... key here
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      if (kDebugMode) {
        print("Payment Intent Response: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print("Error creating payment intent: $e");
      }
      return null;
    }
  }

  String calculateAmount(String amount) {
    final doubleAmount = double.tryParse(amount);
    if (doubleAmount != null) {
      return (doubleAmount * 100).toInt().toString();
    } else {
      throw const FormatException("Invalid amount format");
    }
  }


  Future<void> displayPaymentSheet({required String price}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      retrieveTxnId(paymentIntent: paymentIntentData!['id'], price:price );
      if (kDebugMode) {
        print('Payment intent: $paymentIntentData');
      }
 ToastMessageHelper.showToastMessage("Payment Success");
      paymentIntentData = null;
    } catch (e) {
      if (kDebugMode) {
        print("Error displaying payment sheet: $e");
      }
    }
  }


  Future<void> retrieveTxnId({required String paymentIntent, required String price}) async {
    try {
      // Step 1: Retrieve the payment intent details (charges)
      final response = await http.get(
        Uri.parse('https://api.stripe.com/v1/charges?payment_intent=$paymentIntent'),
        headers: {
          "Authorization": "Bearer ${Config.secretKey}",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String transactionId = data['data'][0]['balance_transaction']; // Get the transaction ID

        if (kDebugMode) {
          print("Transaction Id: $transactionId");
          print("***********payment data: $data");
        }

        // Step 2: Send the subscriptionId and transactionId to your custom API
        Map<String, dynamic> body = {
          "amount": int.parse(price.toString()),
          "trId" : "$transactionId"
        };

        ///API URL

        // Step 3: Call the custom API with the transactionId and subscriptionId
        final apiResponse = await ApiClient.postData(ApiConstants.addBalance, jsonEncode(body));

        if (apiResponse.statusCode==200|| apiResponse.statusCode==201) {

          if (kDebugMode) {
            print("Payment successfully created: ${apiResponse.body}");
          }
        }
      }
    } catch (e) {
    }
  }


}

