import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/HomePage.dart';

class Explore extends StatelessWidget {
  final String username;
  const Explore({required this.username, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      
          SizedBox(height: 200,),
      
          Image.asset('assets/images/verify-security.png', width: 271, height: 260,),
      
          SizedBox(height: 90,),
      
      
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hi ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black

                    )
                  ),
                  TextSpan(
                    text: '$username, ', 
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 6, 114, 202)

                    )
                  ),
                  TextSpan(
                    text: 'Your email has been verified successfully in our system',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    )
                  )
                ]
              )
              ),
            ),
          
      
        
          SizedBox(height: 137,),
      
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 71, 201, 252),
                            Color.fromARGB(255, 0, 132, 252)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                         Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                        },
                        minWidth: double.infinity,
                        height: 45,
                        child: Text(
                          'Explore Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        ),
                      ),
                    ),
          ),

          SizedBox(height: 25,),

          
      
        ],
      ),
    );
  }
}