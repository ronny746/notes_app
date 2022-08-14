import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
            padding: const EdgeInsets.only(top: 160, left: 33, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: 80,
                    child: Image.asset(
                      "assets/Group468.png",
                      fit: BoxFit.contain,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text("Welcome To Notes  ",
                    style: GoogleFonts.akshar(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                  defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromRGBO(234, 239, 243, 1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 50,
                    width: 40,
                  ),
                  focusedPinTheme: PinTheme(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(234, 239, 243, 1)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white)),
                  length: 6,
                  controller: _pinPutController,
                  focusNode: focusNode,
                  separator: const SizedBox(width: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    TextButton(
                      onPressed: () {
                        _verifyPhone();
                      },
                      child: Text(
                        "      Send OTP",
                        style: GoogleFonts.akshar(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 174, 34),
                            shape: BoxShape.circle),
                        margin: const EdgeInsets.only(top: 20),
                        child: IconButton(
                          onPressed: (() async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: _verificationCode!,
                                          smsCode: _pinPutController.text))
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }),
                          icon: const Icon(Icons.arrow_right_alt),
                          iconSize: 40,
                        )),
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
            verifiyied = 1;
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration());
  }
}
