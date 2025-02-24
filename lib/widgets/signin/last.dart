import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/HomePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
   String username = ""; // Default value

  @override
  void initState() {
    super.initState();
    _getUsername(); // Fetch username when the widget initializes
  }

  Future<void> _getUsername() async {
    try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser!.uid; // Get the current user's UID

    // Fetch the document for the current user using their UID
    DocumentSnapshot userDoc = await firestore.collection('Users').doc(uid).get();

    if (userDoc.exists) {
      // Get the username from the document
      setState(() {
        username = userDoc['name'] ?? "User"; // Assuming the field is 'name'
      });
    } else {
      setState(() {
        username = "User"; // Default username if document doesn't exist
      });
    }
  } catch (e) {
    print("Error fetching username: $e");
    setState(() {
      username = "User"; // Default username if there's an error
    });
  }
}







    // Function to retrieve username from SharedPreferences
  // Future<void> _getUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = prefs.getString('username') ?? "User"; // Default if no username found
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      
          SizedBox(height: 160.h,),
      
          Image.asset('assets/images/verify-security.png', width: 271.w, height: 260.h,),
      
          SizedBox(height: 80.h,),
      
      
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
                      color: const Color(0xFF1171D8)

                    )
                  ),
                  TextSpan(
                    text: 'Your email has been verified successfully in our system.',
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
          
      
        
          SizedBox(height: 169,),
      
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3CC8EB),
                            Color(0xFF1171D8)
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
                        height: 44.h,
                        child: Text(
                          'Explore Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
          ),
          
      
        ],
      ),
    );
  }
}