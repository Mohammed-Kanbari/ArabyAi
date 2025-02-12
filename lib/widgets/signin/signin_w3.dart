import 'package:flutter/material.dart';
import 'package:my_araby_ai/widgets/signin/check_email.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SingupW3 extends StatefulWidget {
  const SingupW3({super.key});

  @override
  State<SingupW3> createState() => _SingupW3State();
}

class _SingupW3State extends State<SingupW3> {
 


  // Controller to manage username input
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  String _hintText = 'Username';


  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {
        _hintText = _usernameFocusNode.hasFocus ? '' : 'Username';
      });
    });
    

    
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    SizedBox(height: 80.h),
                          
                          
                    Image.asset('assets/images/Dot3.png', width: 40.w,),
                          
                    SizedBox(height: 20.h),
                    Text(
                      "Let's Pick you a username!",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextField(
                      focusNode: _usernameFocusNode,
                      controller: _usernameController, // Set controller
                      decoration: InputDecoration(
                        hintText: _hintText,
                        hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300
                          ),
                          enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: const Color(0xFFC7C7C7))
                              ),
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
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3CC8EB),
                            Color(0xFF1171D8)
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
                        height: 45.h,
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 15),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/messageRobot3.png',
                             width: 321.w, 
                            height: 310.h, 
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
