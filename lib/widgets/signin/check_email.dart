import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/last.dart';

class CheckEmail extends StatelessWidget {
  final String usernames;
  const CheckEmail({required this.usernames, Key? key}): super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      
          SizedBox(height: 120,),
      
          Image.asset('assets/images/email.png'),
      
          SizedBox(height: 40,),
      
      
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              textAlign: TextAlign.center,
              'A verification e-mail has been sent to your address',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
      
        
          SizedBox(height: 140,),
      
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
                            Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) => Explore(username: usernames)));
                        },
                        minWidth: double.infinity,
                        height: 45,
                        child: Text(
                          'Check your E-mail',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        ),
                      ),
                    ),
          ),

          SizedBox(height: 25,),

          Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Haven't receive a verification ? ",
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(202, 0, 0, 0),
                          fontFamily: 'Poppins'
                        ),
                      ),
              InkWell(
                    onTap: (){
                           
            
                   },
                    child: Text(
                          ' Resend E-mail',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 108, 213, 240),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'
                           ),
                          )
                        ),
        ]),
      
        ],
      ),
    );
  }
}