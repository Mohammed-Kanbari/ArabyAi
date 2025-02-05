import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/Login_page.dart';
import 'package:my_araby_ai/Screens/signup_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            SizedBox(height: 70,),

            Image.asset('assets/images/arabyLogo.png', width: 65, height: 65),

            const SizedBox(height: 25),

            const Text(
              'Getting started',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                ),
              ),

            const SizedBox(height: 12),

            const Text(
              'Create an account to continue !',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),

            const SizedBox(height: 40,),

            const Text(
              '- USE - ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 71, 201, 252),
                               Color.fromARGB(255, 0, 132, 252)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                      ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: (){
                  
                    }, 
                    icon: Icon(Icons.phone_iphone),
                    iconSize: 65,
                    color: Colors.white,
                    ),
                ),

                SizedBox(width: 80,),

                Container(
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 71, 201, 252),
                               Color.fromARGB(255, 0, 132, 252)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                      ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                           MaterialPageRoute(builder: (context) => Singup()),
                           );
                    }, 
                    icon: Icon(Icons.email_outlined),
                    iconSize: 65,
                    color: Colors.white,
                    ),
                ),
                
              ],
            ),

              SizedBox(height: 15,),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Phone',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                

              SizedBox(width: 145,),


                Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            SizedBox(height: 70,),

            Text(
              '- OR -',
              style: TextStyle(
                fontSize: 16,
                ),
              ),

            SizedBox(height: 35,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton
                (
                  onPressed: (){

                  },
                  icon: Icon(Icons.facebook_rounded,
                             size: 55,
                             color: const Color.fromARGB(255, 58, 85, 159),
                             ),
                  ),

                  SizedBox(width: 22,),

                IconButton
                (
                  onPressed: (){

                  },
                  icon:  Image.asset('assets/images/googleLogo2.png', width: 50, height: 50,),
                  ),

                  SizedBox(width: 20,),

                IconButton
                (
                  onPressed: (){

                  },
                  icon: Image.asset('assets/images/appleIcon2.png', width: 60, height: 60,),
                  ),
                ],
              ),

              SizedBox(height: 130,),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By Registering you agree to our ',
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color.fromARGB(202, 0, 0, 0),
                          fontFamily: 'Poppins'
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          
                        },
                        child: Text(
                          'Terms of Use',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'
                          ),
                          )
                        ),

                        Text(
                        ' and ',
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color.fromARGB(202, 0, 0, 0),
                          fontFamily: 'Poppins'
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          
                        },
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'
                          ),
                          )
                        ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have and account?',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(202, 0, 0, 0),
                          fontFamily: 'Poppins'
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(
                          context,
                           MaterialPageRoute(builder: (context) => Login()),
                           );

                        },
                        child: Text(
                          ' Log in',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 108, 213, 240),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'
                          ),
                          )
                        )
                    ],
                  )


                   ],
                ),



          ],
        ),
      ),
    );
  }
}