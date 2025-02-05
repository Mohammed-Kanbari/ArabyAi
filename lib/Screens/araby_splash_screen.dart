import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_araby_ai/Screens/welcome.dart';

class Araby_SC extends StatefulWidget {
  const Araby_SC({super.key});

  @override
  State<Araby_SC> createState() => _Araby_SCState();
}



class _Araby_SCState extends State<Araby_SC> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);


    // Navigate to the Home page after animation ends (adjust duration accordingly)
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 71, 201, 252),
              const Color.fromARGB(255, 255, 255, 255)
            ],
            stops: [0.1, 0.5],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/images/arabyLogo.png', width: 116, height: 130, alignment: Alignment(320, -390),),
            ),

            Align(
              alignment: Alignment(0, 0.1),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [const Color.fromARGB(255, 71, 201, 252), const Color.fromARGB(255, 0, 132, 252)], // Gradient colors for text
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                blendMode:BlendMode.srcIn,
              child: Text(
                'ARABY AI',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter' 
                ),),
            ),
        )],
        ),
      )
    );
  }
}