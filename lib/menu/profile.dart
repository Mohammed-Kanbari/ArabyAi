import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? selectedNum = 'UAE +971';

  final List<String> _Numbers = ['UAE +971', 'USA +01', 'UK +671'];
  DateTime? selectedDate;
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/cross.png',
                        width: 32,
                        height: 32,
                      ),
                    )
                  ],
                ),
                kGap40,
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width:
                            158.0, // Add border width (e.g., 4.0 x 2) to width and height
                        height: 158.0,
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
                            width: 150.0, // Original container size
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: AssetImage('assets/images/Rectangle.png'),
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
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(116, 116)),
                                boxShadow: [
                                  BoxShadow(blurRadius: 65, spreadRadius: 0),
                                ]),
                          ),
                          Positioned(
                            bottom: 7,
                            left: 7,
                            child: SvgPicture.asset(
                              AppPhoto.pencil,
                              width: 24,
                              height: 24,
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
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                kGap10,
                //TODO: The username must be here
                TextField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: false,
                  decoration: InputDecoration(
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
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      contentPadding: EdgeInsets.all(10)),
                ),
            
                kGap15,
            
                Text(
                  'E-mail Address :',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                kGap10,
                //TODO: The const email must be here
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
                        borderSide:
                            BorderSide(color: const Color(0xFFC7C7C7), width: 1),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: const Color(0xFFC7C7C7)),
                      ),
                      contentPadding: EdgeInsets.all(10)),
                ),
            
                kGap15,
            
                Text(
                  'Phone Number :',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                kGap10,
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 130,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        value: selectedNum,
                        onChanged: (newValue) {
                          setState(() {
                            selectedNum = newValue;
                          });
                        },
                        items: _Numbers.map((number) => DropdownMenuItem(
                            value: number, child: Text(number))).toList(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 180, 179, 179),
                                    width: 1)),
                            contentPadding: EdgeInsets.all(10),
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
                    Container(
                      width: 250,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        expands: false,
                        decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            hintStyle: TextStyle(
                                color: const Color.fromARGB(255, 183, 182, 182),
                                fontSize: 14),
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
                            contentPadding: EdgeInsets.all(10)),
                      ),
                    ),
                  ],
                ),
            
                kGap15,
                Text(
                  'Occupation :',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                kGap10,
                //TODO: The username must be here
                TextField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: false,
                  decoration: InputDecoration(
                      hintText: 'Enter your occupation',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 183, 182, 182),
                          fontSize: 14),
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
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      contentPadding: EdgeInsets.all(10)),
                ),
            
                kGap15,
                Text(
                  'Date of Birth :',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                kGap10,
                TextField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: TextEditingController()
                   ..text = selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : '',
                  maxLines: null,
                  expands: false,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            var pickedDate = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.calendarOnly,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2030),
                            );
            
                            if(pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          icon: Icon(Icons.calendar_today_outlined)
                        ),
                      hintText: 'DD/MM/YYYY',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 183, 182, 182),
                          fontSize: 14),
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
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      contentPadding: EdgeInsets.all(10)),
                      
                ),
                /////////
            
                kGap40,
            
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 71, 201, 252),
                        Color.fromARGB(255, 0, 132, 252)
                      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                          shadowColor: Colors.transparent,
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 130),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}