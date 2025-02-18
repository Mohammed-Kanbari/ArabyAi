import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? selectedNum = 'UAE +971';

  final List<String> _Numbers = ['UAE +971', 'USA +01', 'UK +671'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              children: [
                // Fixed Top Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/cross.png',
                          width: 32.w,
                          height: 32.h,
                        ),
                      )
                    ],
                  ),
                ),
                kGap20,

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 158.0.w,
                                height: 158.0.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF4042E2),
                                      const Color(0xFFDB63C3),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.elliptical(116, 116)),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 150.0.w,
                                    height: 150.0.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/Rectangle.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.elliptical(158, 158)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                bottom: 7,
                                child: Stack(children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(116, 116)),
                                        boxShadow: [
                                          BoxShadow(blurRadius: 65, spreadRadius: 0),
                                        ]),
                                  ),
                                  Positioned(
                                    bottom: 7,
                                    left: 7,
                                    child: SvgPicture.asset(
                                      AppPhoto.pencil,
                                      width: 24.w,
                                      height: 24.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        kGap30,
                        Text(
                          'Name :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        TextField(
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp),
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 180, 179, 179),
                                  width: 1.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 195, 194, 194)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.blueAccent, width: 1.w),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                
                        kGap15,
                
                        Text(
                          'E-mail Address :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        TextField(
                          enabled: false,
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: false,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF5F5F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: const Color(0xFFC7C7C7), width: 1.w),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: const Color(0xFFC7C7C7)),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                        ),
                
                        kGap15,
                
                        Text(
                          'Phone Number :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                height: 44.h,
                                child: DropdownButtonFormField(
                                  dropdownColor: Colors.white,
                                  value: selectedNum,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedNum = newValue;
                                    });
                                  },
                                  items: _Numbers.map((number) => DropdownMenuItem(
                                      value: number,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          number,
                                          style: TextStyle(
                                              fontFamily: 'Poppins', fontSize: 14.sp),
                                        ),
                                      ))).toList(),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(255, 180, 179, 179),
                                              width: 1)),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(255, 195, 194, 194))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent, width: 1))),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Flexible(
                              flex: 4,
                              child: Container(
                                height: 44.h,
                                child: TextField(
                                  style:
                                      TextStyle(fontFamily: 'Poppins', fontSize: 16.sp),
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 1,
                                  expands: false,
                                  decoration: InputDecoration(
                                      hintText: 'Enter your phone number',
                                      hintStyle: TextStyle(
                                          color: const Color(0xFFC7C7C7),
                                          fontSize: 14.sp),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color:
                                                const Color.fromARGB(255, 180, 179, 179),
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color:
                                                const Color.fromARGB(255, 195, 194, 194)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent, width: 1),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12)),
                                ),
                              ),
                            ),
                          ],
                        ),
                
                        kGap15,
                        Text(
                          'Occupation :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        TextField(
                          style: TextStyle(fontSize: 16.sp, fontFamily: 'Poppins'),
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: false,
                          decoration: InputDecoration(
                              hintText: 'Enter your occupation',
                              hintStyle: TextStyle(
                                  color: const Color(0xFFC7C7C7), fontSize: 14.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 180, 179, 179),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 195, 194, 194)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent, width: 1),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                        ),
                
                        kGap15,
                        Text(
                          'Date of Birth :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        TextField(
                          style: TextStyle(fontSize: 16.sp, fontFamily: 'Poppins'),
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                size: 24.sp,
                                Icons.calendar_today_outlined,
                                color: const Color.fromARGB(255, 183, 182, 182),
                              ),
                              hintText: 'DD/MM/YYYY',
                              hintStyle: TextStyle(
                                  color: const Color.fromARGB(255, 183, 182, 182),
                                  fontSize: 14.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 180, 179, 179),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 195, 194, 194)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent, width: 1),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                        ),
                
                        kGap40,
                
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xFF3CC8EB), Color(0xFF1171D8)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(0, 255, 255, 255),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                        ),
                        SizedBox(height: 10.h,)
                      ],
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
