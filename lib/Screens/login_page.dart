import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/get_started.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
          
                Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset('assets/images/arabyLogo.png', width: 65, height: 65),
                    const SizedBox(height: 25),
                    const Text(
                      "Let's sign you in",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Welcome back, you have been missed !',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
          
                SizedBox(height: 80),
          
                Form(
                  child: Column(
                    children: [
                      
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'E-mail Address :',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
          
                      SizedBox(height: 10),
          
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2), // Blue color when focused
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1), // Grey color when not focused
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter email' : null;
                          },
                        ),
                      ),
          
                      SizedBox(height: 29),
          
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'Password :',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
          
                      SizedBox(height: 10),
          
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _passwordController,
                          autocorrect: false,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter password' : null;
                          },
                        ),
                      ),
          
                      SizedBox(height: 5,),
          
                      Align(
                        alignment: Alignment(-0.95, 0),
                        child: TextButton(
                          onPressed: (){
          
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 117, 116, 116)
                            ),
                          )
                        )
                      ),
          
                      SizedBox(height: 17,),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(255, 71, 201, 252),
                                       Color.fromARGB(255, 0, 132, 252)
                        ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                          ),
                          child: MaterialButton(
                            onPressed: (){
                          
                          },
                            minWidth: double.infinity,
                            height: 45,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                              ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          
                SizedBox(height: 45,),
          
                Text(
                '- OR -',
                style: TextStyle(
                  fontSize: 16,
                  ),
                ),
          
              SizedBox(height: 13,),
          
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
          
                SizedBox(height: 37,),
          
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(202, 0, 0, 0),
                            fontFamily: 'Poppins'
                          ),
                        ),
          
                        InkWell(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(
                            context,
                             MaterialPageRoute(builder: (context) => GetStarted()),(route) => false);
                             
          
                          },
                          child: Text(
                            ' Sign up',
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
          ),
        ),
      );
    });
  }
}
