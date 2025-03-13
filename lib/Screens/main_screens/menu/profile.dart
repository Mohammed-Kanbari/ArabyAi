import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_araby_ai/providers/user_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? selectedNum = 'UAE +971';

  final List<String> _Numbers = ['UAE +971', 'USA +1', 'UK +44'];

  // Variables to hold username and email
  late TextEditingController _emailController;

  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _occupationController;
  late TextEditingController _dobController;

  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    _occupationController = TextEditingController();
    _dobController = TextEditingController();

    _loadUserDate();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _occupationController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // Load date from UserProvider, fallback to Firestore if needed
  void _loadUserDate() {
    UserProvider provider = context.read<UserProvider>();
    User? user = FirebaseAuth.instance.currentUser;

    if (provider.username != null && provider.firebaseUid == user?.uid) {
      setState(() {
        _emailController.text = provider.email ?? '';
        _usernameController.text = provider.username ?? '';
        _updatePhoneFields(provider.phone ?? '+971123456789');
        _occupationController.text =
            provider.occupation ?? ''; 
        _dobController.text =
            provider.dob ?? ''; 
        _profileImageUrl = provider.profilePictureUrl;
      });
    }
    // Fetch from Firestore if UserProvider is incomplete
    _fetchUserDataFromFirestore();
  }

  void _updatePhoneFields(String phone) {
    if (phone.startsWith('+971')) {
      selectedNum = 'UAE +971';
      _phoneController.text = phone.replaceFirst('+971', '');
    } else if (phone.startsWith('+1')) {
      selectedNum = 'USA +1';
      _phoneController.text = phone.replaceFirst('+1', '');
    } else if (phone.startsWith('+44')) {
      selectedNum = 'UK +44';
      _phoneController.text = phone.replaceFirst('+44', '');
    } else {
      selectedNum = 'UAE +971'; // Default
      _phoneController.text = phone;
    }
  }

  Future<void> _fetchUserDataFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          UserProvider provider = context.read<UserProvider>();
          setState(() {
            _emailController.text = userDoc['email'] ?? provider.email ?? '';
            _usernameController.text =
                userDoc['name'] ?? provider.username ?? '';
            _updatePhoneFields(
                userDoc['phone'] ?? provider.phone ?? '+971 123456789');
            _occupationController.text = userDoc['occupation'] ?? '';
            _dobController.text = userDoc['dob'] ?? '';
            _profileImageUrl =
                userDoc['profilePictureUrl'] ?? provider.profilePictureUrl;
          });
          // Update UserProvider with Firestore data
          provider.setEmail(_emailController.text);
          provider.setUsername(_usernameController.text);
          provider.setPhone(_phoneController.text);
          provider.setProfilePictureUrl(_profileImageUrl);
          provider.setOccupation(_occupationController.text);
          provider.setDob(_dobController.text);
          // Add new fields to UserProvider if needed (see below)
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load profile: $e')));
      }
    }
  }

  Future<void> _pickAndSaveImageLocally() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        final directory = await getApplicationDocumentsDirectory();
        final fileName =
            '${FirebaseAuth.instance.currentUser!.uid}_profile_pic.jpg';
        final localPath = '${directory.path}/$fileName';
        await imageFile.copy(localPath);

        UserProvider provider = context.read<UserProvider>();
        provider.setProfilePictureUrl(localPath);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePictureUrl': localPath});

        setState(() {
          _profileImageUrl = localPath;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile picture updated')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to save image: $e')));
      }
    }
  }

  Future<void> _saveChanges() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String countryCode = selectedNum!.split(' ').last; // e.g., "+971" from "UAE +971"
      String fullPhoneNumber = _phoneController.text.isNotEmpty
          ? '$countryCode${_phoneController.text}'
          : _phoneController.text;

      if (_phoneController.text.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(_phoneController.text)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Phone number must contain only digits')));
        return;
      }

      try {
        // Update Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'name': _usernameController.text,
          'phone': fullPhoneNumber,
          'occupation': _occupationController.text,
          'dob': _dobController.text,
          'profilePictureUrl': _profileImageUrl,
        });

        // Update UserProvider
        UserProvider provider = context.read<UserProvider>();
        provider.setUsername(_usernameController.text);
        provider.setPhone(fullPhoneNumber);
        provider.setProfilePictureUrl(_profileImageUrl);
        provider.setOccupation(_occupationController.text);
        provider.setDob(_dobController.text);
        // Add occupation and dob to UserProvider if needed (see below)

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: $e')));
      }
    }
  }

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
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(116, 116)),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 150.0.w,
                                        height: 150.0.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff7c94b6),
                                          image: _profileImageUrl != null
                                              ? DecorationImage(
                                                  image: FileImage(File(
                                                      _profileImageUrl!)), // Use FileImage to load from local storage
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/Rectangle.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(158, 158)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 7,
                                    child: GestureDetector(
                                      onTap: _pickAndSaveImageLocally,
                                      child: Stack(children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.elliptical(116, 116)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 65,
                                                    spreadRadius: 0),
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
                                    ),
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
                              controller: _usernameController,
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 16.sp),
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 180, 179, 179),
                                      width: 1.w),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 195, 194, 194)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1.w),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
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
                              controller: _emailController,
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
                                        color: const Color(0xFFC7C7C7),
                                        width: 1.w),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: const Color(0xFFC7C7C7)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12)),
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
                                      items: _Numbers.map(
                                          (number) => DropdownMenuItem(
                                              value: number,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  number,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14.sp),
                                                ),
                                              ))).toList(),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 180, 179, 179),
                                                  width: 1)),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 195, 194, 194))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(color: Colors.blueAccent, width: 1))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Container(
                                    height: 44.h,
                                    child: TextField(
                                      controller: _phoneController,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.sp),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      expands: false,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your phone number',
                                          hintStyle: TextStyle(
                                              color: const Color(0xFFC7C7C7),
                                              fontSize: 14.sp),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 180, 179, 179),
                                                width: 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: const Color.fromARGB(
                                                    255, 195, 194, 194)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                                width: 1),
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
                              controller: _occupationController,
                              style: TextStyle(
                                  fontSize: 16.sp, fontFamily: 'Poppins'),
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: false,
                              decoration: InputDecoration(
                                  hintText: 'Enter your occupation',
                                  hintStyle: TextStyle(
                                      color: const Color(0xFFC7C7C7),
                                      fontSize: 14.sp),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 180, 179, 179),
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 195, 194, 194)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 1),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12)),
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
                              controller: _dobController,
                              style: TextStyle(
                                  fontSize: 16.sp, fontFamily: 'Poppins'),
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  size: 24.sp,
                                  Icons.calendar_today_outlined,
                                  color:
                                      const Color.fromARGB(255, 183, 182, 182),
                                ),
                                hintText: 'DD/MM/YYYY',
                                hintStyle: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 183, 182, 182),
                                    fontSize: 14.sp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 180, 179, 179),
                                      width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 195, 194, 194)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              readOnly: true, // Prevents keyboard from showing
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  _dobController.text =
                                      "${picked.day}/${picked.month}/${picked.year}";
                                }
                              },
                            ),
                            Spacer(),
                            kGap40,
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF3CC8EB),
                                        Color(0xFF1171D8)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ElevatedButton(
                                  onPressed: _saveChanges,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          0, 255, 255, 255),
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    'Save Changes',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 30.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
