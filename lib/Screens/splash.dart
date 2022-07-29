import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Screens/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/background.png",
            fit: BoxFit.cover,
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 100),
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "assets/Group468.png",
                      fit: BoxFit.contain,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Text(
                  "Welcome To Notes",
                  style: GoogleFonts.roboto(fontSize: 30, color: Colors.white),
                ),
              )
            ]),
      ]),
    );
  }
}
