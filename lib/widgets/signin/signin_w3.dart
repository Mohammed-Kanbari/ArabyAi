import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/check_email.dart';


class SingupW3 extends StatefulWidget {
  const SingupW3({super.key});

  @override
  State<SingupW3> createState() => _SingupW3State();
}

class _SingupW3State extends State<SingupW3> {
 

  final FocusNode _focusNode = FocusNode();
  double _opacity = 0.5;

  // Controller to manage username input
  final TextEditingController _usernameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _opacity = _focusNode.hasFocus ? 1.0 : 0.5;
      });
    });

    
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      SizedBox(height: 70),
            
            
                      Image.asset('assets/images/Dot3.png', width: 40,),
            
                      SizedBox(height: 20),
                      Text(
                        "Let's Pick you a username!",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      Opacity(
                        opacity: _opacity,
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _usernameController, // Set controller
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.replay_outlined, color: Colors.blue),
                              onPressed: () {
                                // Reset username field
                                _usernameController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 71, 201, 252),
                              Color.fromARGB(255, 0, 132, 252)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => CheckEmail(usernames: _usernameController.text)),(route) => false
                              );
            
                          },
                          minWidth: double.infinity,
                          height: 45,
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Image.asset(
                          'assets/images/messageRobot3.png',
                          width: 350,
                          height: 350,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
