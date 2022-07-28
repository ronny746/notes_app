import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/Screens/home.dart';
import 'package:pinput/pinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  FocusNode focusNode = FocusNode();
  final controller = TextEditingController();
  int verifiyied = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 120,
                    width: 100,
                    child: Image.asset(
                      "assets/Group468.png",
                      fit: BoxFit.contain,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome To Notes  ",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter the mobile number",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  onSubmitted: ((pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode!, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          verifiyied = 1;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()),
                              (route) => false);
                        }
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }),
                  length: 6,
                  controller: _pinPutController,
                  focusNode: focusNode,
                  separator: SizedBox(width: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _verifyPhone();
                      },
                      child: Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 50,
                        color: Colors.greenAccent,
                      ),
                      onPressed: () {
                        if (verifiyied == 0) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${mobileController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
}
