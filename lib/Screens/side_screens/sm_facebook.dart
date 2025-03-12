import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/side_screens/theStatus.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SmFacebook extends StatefulWidget {
  const SmFacebook({super.key});

  @override
  State<SmFacebook> createState() => _SmFacebookState();
}

class _SmFacebookState extends State<SmFacebook> {
  final List<String> _languages = ['English', 'Arabic'];
  final List<String> _tone = ['Professional', 'Casual', 'Friendly', 'Formal'];

  final TextEditingController postAbout_Controller = TextEditingController();

  bool isButtononEnabled = false;
  bool isLoading = false;
  String generatedStatus = '';
  String errorMessage = '';

  String? _selectedLanguage = 'English';
  String? _selectedTone;

  @override
  void initState() {
    super.initState();
    postAbout_Controller.addListener(_validateFields);
  }

  @override
  void dispose() {
    postAbout_Controller.dispose();
    super.dispose();
  }

  void _validateFields() {
    final bool isFormValid =
        postAbout_Controller.text.isNotEmpty && _selectedTone != null;

    setState(() {
      isButtononEnabled = isFormValid;
    });
  }

  Future<void> generatedFBStatus() async {
    if (!isButtononEnabled || isLoading) return;

    setState(() {
      isLoading = true;
      generatedStatus = '';
      errorMessage = '';
    });

    try {
      const String apiToken = 'KBXuciWibf7lXWdriz5dcFo3ISego3Y3r4nymmL8'; // Replace with your Cohere key
      final String fullPrompt = "Generate a short Facebook status in $_selectedLanguage about '${postAbout_Controller.text}' in a $_selectedTone tone.";

      final response = await http.post(
        Uri.parse('https://api.cohere.ai/v1/generate'),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': fullPrompt,
          'max_tokens': 50,
          'temperature': 0.7,
          'num_generations': 3,
        }),
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<String> statuses = (data['generations'] as List)
            .map((gen) {
              String rawText = gen['text'] ?? 'No status generated';
              return rawText.startsWith(fullPrompt)
                  ? rawText.substring(fullPrompt.length).trim()
                  : rawText;
            })
            .toList();
        setState(() {
          isLoading = false;
        });
        // Navigate to the result page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FB_Status(generatedStatuses: statuses),
          ),
        );
      } else {
        String errorDetail = 'Unknown error';
        if (response.body.isNotEmpty) {
          try {
            final errorBody = jsonDecode(response.body);
            errorDetail = errorBody['message'] ?? 'Unknown error';
          } catch (_) {
            errorDetail = 'Failed to parse error response';
          }
        }
        setState(() {
          errorMessage = 'Failed ${response.statusCode}: $errorDetail';
          isLoading = false;
        });
        // Navigate to show error
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FB_Status(generatedStatuses: [errorMessage], isError: true),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FB_Status(generatedStatuses: [errorMessage], isError: true),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 27.h),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, size: 24.sp)),
                    Text(
                      'Facebook Status',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                kGap25,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please select the language :',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          value: _selectedLanguage,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLanguage = newValue;
                            });
                            _validateFields();
                          },
                          items: _languages
                              .map((language) => DropdownMenuItem(
                                  value: language,
                                  child: Text(
                                    language,
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16.sp),
                                  )))
                              .toList(),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 180, 179, 179),
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(0xFFC7C7C7))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1))),
                        ),
                        kGap25,
                        Text(
                          'What would you like to post about ?',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        TextField(
                          controller: postAbout_Controller,
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            hintText: 'Type here..',
                            hintStyle: TextStyle(
                                color: const Color.fromARGB(255, 183, 182, 182),
                                fontSize: 14.sp,
                                fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 180, 179, 179),
                                  width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: const Color(0xFFC7C7C7)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.blueAccent, width: 1),
                            ),
                          ),
                        ),
                        kGap25,
                        Text(
                          'How do you want the caption to sound ?',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                        kGap10,
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          value: _selectedTone,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedTone = newValue;
                            });
                            _validateFields();
                          },
                          items: _tone
                              .map((tone) => DropdownMenuItem(
                                  value: tone,
                                  child: Text(tone,
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16.sp))))
                              .toList(),
                          hint: Text(
                            'Select tone',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                color: const Color.fromARGB(255, 183, 182, 182)),
                          ),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 180, 179, 179),
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 195, 194, 194))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1))),
                        ),
                        SizedBox(height: 40.h), // Adds space before button
                      ],
                    ),
                  ),
                ),
                // Button always stays at the bottom
                Container(
                  width: double.infinity,
                  decoration: isButtononEnabled
                      ? BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF3CC8EB), Color(0xFF1171D8)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(10))
                      : BoxDecoration(
                          color: const Color.fromARGB(0, 238, 238, 238),
                          borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                      onPressed: isButtononEnabled ? generatedFBStatus : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: isLoading ? const CircularProgressIndicator(color: Colors.white,) : 
                          Text(
                          'Generate',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: isButtononEnabled
                                  ? Colors.white
                                  : const Color.fromARGB(121, 182, 174, 174)),
                        ),
                      )),
                
                SizedBox(height: 30.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
