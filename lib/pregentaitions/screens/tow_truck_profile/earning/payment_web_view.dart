import 'package:autorevive/helpers/quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../controllers/payment_controller.dart';
import '../../../widgets/custom_text.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebView({
    super.key,
    required this.paymentUrl,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {

  final PaymentController _paymentController = Get.put(PaymentController());

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            // Handle loading progress if needed
          },
          onPageStarted: (url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (url) {
            debugPrint('Page finished loaded: $url');
            _paymentController.paymentResults(finishUrl: url, context: context);
          },
          onHttpError: (error) {
            debugPrint('HTTP error: ${error.request}');
          },
          onWebResourceError: (error) {
            debugPrint('Web resource error: ${error.description}');
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent; // Block YouTube links
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        backgroundColor:  Colors.blueAccent,
        centerTitle: true,
        title:  CustomText(
          text: "Payment",
          fontsize: 15,
          color: Colors.white,
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
