import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyPaymentPage extends StatefulWidget {
  @override
  _MyPaymentPageState createState() => _MyPaymentPageState();
}

class _MyPaymentPageState extends State<MyPaymentPage> {
  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Razorpay Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(),
            Text("You'll be paying INR 20.00 for this demo"),
            Divider(),
            Text("Test Card number is 4111-1111-1111-1111"),
            Divider(),
            Text('Fill other fields randomly.'),
            Divider(),
            Text('A default phone and email is pre-filled.'),
            Divider(),
            Text('Select outcome to see success and failure cases.'),
            Divider(),
            Text('Payment can be verified in razorpay dashboard.'),
            Divider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: FlatButton(
          onPressed: openCheckout,
          child: Text(
            'Test Payment',
            textScaleFactor: 1.2,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_K4qqgkI6Wzh2KO',
      'amount': 2000,
      'name': 'Qc4 Application',
      'description': 'HomeCook Wallet',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }
}
