import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_araby_ai/Screens/starting_screens/welcome.dart';

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

    // Navigate to the WelcomePage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 71, 201, 252),
              Color.fromARGB(255, 255, 255, 255)
            ],
            stops: [0.1, 0.5],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.33,),
              Image.asset(
                'assets/images/arabyLogo.png',
                width: screenWidth * 0.28,  // 30% of screen width
                height: screenHeight * 0.2, // 20% of screen height
                fit: BoxFit.contain,
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 71, 201, 252),
                    Color.fromARGB(255, 0, 132, 252)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  'ARABY AI',
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,  // 8% of screen width
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
