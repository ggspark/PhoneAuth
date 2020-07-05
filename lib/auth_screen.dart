import 'package:PhoneAuth/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String verificationId = "";

  @override
  void initState() {
    _phoneController.addListener(() {
      setState(() {});
    });
    _codeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void verficationCompleted(
      AuthCredential authCredential, BuildContext context) {
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((AuthResult result) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(result.user)));
    }).catchError((e) {
      showToast("Invalid code");
      print(e);
    });
  }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (cred) => verficationCompleted(cred, context),
        verificationFailed: (AuthException authException) {
          showToast("Incorrect Phone Number");

          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              verificationId.isNotEmpty
                  ? TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorStyle: Theme.of(context).textTheme.caption,
                          hintText: "Enter Code"),
                      controller: _codeController,
                      maxLength: 6,
                      validator: (value) {
                        return isCodeValid(value) ? "Continue" : "Input code";
                      },
                    )
                  : TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorStyle: Theme.of(context).textTheme.caption,
                          hintText: "Phone Number"),
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      maxLength: 13,
                      validator: (value) {
                        return isPhoneValid(value)
                            ? "Continue"
                            : "Input format. Eg: +91XXXXXXXXXX";
                      },
                    ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("Login"),
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  padding: EdgeInsets.all(16),
                  onPressed: verificationId.isNotEmpty
                      ? isCodeValid(_codeController.text)
                          ? () {
                              String smsCode = _codeController.text.trim();
                              AuthCredential _credential =
                                  PhoneAuthProvider.getCredential(
                                      verificationId: verificationId,
                                      smsCode: smsCode);
                              verficationCompleted(_credential, context);
                            }
                          : null
                      : isPhoneValid(_phoneController.text)
                          ? () {
                              final mobile = _phoneController.text.trim();
                              registerUser(mobile, context);
                            }
                          : null,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isCodeValid(String value) => (value.trim().length == 6);

  bool isPhoneValid(String value) =>
      (value.trim().length == 13 && value.startsWith("+"));
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0);
}
