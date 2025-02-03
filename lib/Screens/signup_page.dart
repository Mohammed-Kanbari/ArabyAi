import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/signin_w2.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final FocusNode _focusNode = FocusNode();
  double _opacity = 0.7;

  final _formKey = GlobalKey<FormState>();

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset('assets/images/cross.png', width: 32, height: 32,))
                        ],
                      ),
                      SizedBox(height: 38),
                      Image.asset(
                        'assets/images/Dot1.png',
                        width: 40,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Hi there,',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Please enter your e-mail address',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Opacity(
                          opacity: _opacity,
                          child: TextFormField(
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'you@example.com',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              String emailPattern =
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                              RegExp regex = RegExp(emailPattern);
                              if (!regex.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
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
                              Color.fromARGB(255, 0, 132, 252),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) =>
                                      SingupW2(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            }
                          },
                          minWidth: double.infinity,
                          height: 45,
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      // Dynamically resize the image
                      Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Image.asset(
                          'assets/images/messageRobot.png',
                          width: 350, 
                          height: 359, 
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
