import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/signin_w3.dart';

class SingupW2 extends StatefulWidget {
  const SingupW2({super.key});

  @override
  State<SingupW2> createState() => _SingupW2State();
}

class _SingupW2State extends State<SingupW2> {


  final FocusNode _focusNode = FocusNode();
  double _opacity = 0.5;

  // State to manage password visibility
  bool _isPasswordVisible = false;

  // Form key to validate form
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
                      
                      SizedBox(height: 70,),
                      
            
                      Image.asset('assets/images/Dot2.png', width: 40,),
            
            
                      SizedBox(height: 20,),
                      Text(
                        'Now secure it with password',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Please enter your a password',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20,),
            
                      // Use Form and TextFormField to handle validation
                      Form(
                        key: _formKey,
                        child: Opacity(
                          opacity: _opacity,
                          child: TextFormField(
                            focusNode: _focusNode,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Minimum 8 characters',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';
                              }
                              // Password validation logic
                              if (value.length < 8 || value.length > 16) {
                                return 'Password must be between 8 and 16 characters';
                              }
                              if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                                return 'Password must contain at least one lowercase letter';
                              }
                              if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                                return 'Password must contain at least one uppercase letter';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
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
                            // Validate the form before navigating
                            if (_formKey.currentState?.validate() ?? false) {
                                Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2)=>SingupW3(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero));
                            }
                          },
                          minWidth: double.infinity,
                          height: 45,
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(height: 45,),
                      Container(
                          padding: EdgeInsets.only(left: 50),
                          child: Image.asset(
                            'assets/images/messageRobot2.png',
                            width: 350,
                            height: 350,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
