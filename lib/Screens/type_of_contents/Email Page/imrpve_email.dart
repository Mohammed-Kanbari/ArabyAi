import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImrpveEmail extends StatefulWidget {
  const ImrpveEmail({super.key});

  @override
  State<ImrpveEmail> createState() => _ImrpveEmailState();
}

class _ImrpveEmailState extends State<ImrpveEmail> {
  final List<String> _languages = ['English', 'Arabic'];
  final List<String> _tone = ['Professional', 'Casual', 'Friendly', 'Formal'];

  final TextEditingController email_Controller = TextEditingController();
  final TextEditingController sender_Controller = TextEditingController();
  final TextEditingController recipient_Controller = TextEditingController();

  bool isButtononEnabled = false;

  bool isLoading = false;
  String improvedEmail = '';
  String errorMessage = '';


  String? _selectedLanguage = 'English';
  String? _selectedTone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    email_Controller.addListener(_validateFields);
    sender_Controller.addListener(_validateFields);
    recipient_Controller.addListener(_validateFields);
  }

  @override
  void dispose() {
    email_Controller.dispose();
    sender_Controller.dispose();
    recipient_Controller.dispose();
    super.dispose();
  }

  void _validateFields() {
    final bool isFormValid = email_Controller.text.isNotEmpty &&
        sender_Controller.text.isNotEmpty &&
        recipient_Controller.text.isNotEmpty &&
        _selectedTone != null;

    setState(() {
      isButtononEnabled = isFormValid;
    });
  }

  Future<void> improveEmail() async {
    if (!isButtononEnabled || isLoading) return;

    setState(() {
      isLoading = true;
      improvedEmail = '';
      errorMessage = '';
    });

    try {
      const String apiToken = 'KBXuciWibf7lXWdriz5dcFo3ISego3Y3r4nymmL8'; // Replace with your Cohere key
      final String fullPrompt = "Paraphrase this text into a $_selectedTone tone: '${email_Controller.text}'";

      final response = await http.post(
        Uri.parse('https://api.cohere.ai/v1/generate'),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': fullPrompt,
          'max_tokens': 150, // Allow enough for email body
          'temperature': 0.7,
        }),
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String rawText = data['generations'][0]['text'] ?? 'No improvement generated';
        final promptPrefix = "Paraphrase this text into a $_selectedTone tone: '";
        final improvedText = rawText.startsWith(promptPrefix)
            ? rawText.substring(promptPrefix.length).trim().replaceAll("'", "")
            : rawText;
        setState(() {
          improvedEmail = "Subject: Improved Email\nFrom: ${sender_Controller.text}\nTo: ${recipient_Controller.text}\n\n$improvedText";
          isLoading = false;
        });
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
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 27.h,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 24.sp,
                        )),
                    Text(
                      'Improve Your E-mail',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                kGap25,
                Flexible(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
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
                                              fontFamily: 'Poppins',
                                              fontSize: 16.sp),
                                        )))
                                    .toList(),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color(0xFFC7C7C7))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1))),
                              ),
                              kGap25,
                              Text(
                                'Enter the E-mail body that you would like to improve :',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                              kGap10,
                              SizedBox(
                                height: 129.h,
                                child: TextField(
                                  controller: email_Controller,
                                  maxLines: null,
                                  expands: true,
                                  style: TextStyle(
                                      fontSize: 16.sp, fontFamily: 'Poppins'),
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    hintText:
                                        'Lorem ipsum dolor sit amet consectetur. Est dolor feugiat morbi viverra. Sodales rutrum in a tempor eros arcu mollis nullam sed.',
                                    hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300),
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
                                  ),
                                ),
                              ),
                              kGap25,
                              Text(
                                'From :',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                              kGap10,
                              TextField(
                                controller: sender_Controller,
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: null,
                                expands: false,
                                decoration: InputDecoration(
                                  hintText: 'Sender Name',
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
                              ),
                              kGap25,
                              Text(
                                'To :',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                              kGap10,
                              TextField(
                                controller: recipient_Controller,
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: null,
                                expands: false,
                                decoration: InputDecoration(
                                  hintText: 'Recipient Name',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
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
                                        child: Text(
                                          tone,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Poppins'),
                                        )))
                                    .toList(),
                                hint: Text(
                                  'Select tone',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      color: const Color.fromRGBO(
                                          183, 182, 182, 1)),
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 180, 179, 179),
                                            width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 195, 194, 194))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1))),
                              ),
                              Spacer(),
                              kGap60,
                              kGap20,
                              Container(
                                width: double.infinity,
                                decoration: isButtononEnabled
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF3CC8EB),
                                              Color(0xFF1171D8)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                        borderRadius: BorderRadius.circular(10))
                                    : BoxDecoration(
                                        color: const Color.fromARGB(
                                            0, 238, 238, 238),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                child: ElevatedButton(
                                    onPressed: isButtononEnabled ? improveEmail : null,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: isLoading ? const CircularProgressIndicator(color: Colors.white,)
                                      : Text(
                                        'Generate',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: isButtononEnabled
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    121, 182, 174, 174)),
                                      ),
                                    )),
                              
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
      ),
      floatingActionButton: improvedEmail.isNotEmpty || errorMessage.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (improvedEmail.isNotEmpty)
                            Text(
                              improvedEmail,
                              style: TextStyle(fontSize: 16.sp, fontFamily: 'Poppins'),
                            ),
                          if (errorMessage.isNotEmpty)
                            Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      if (errorMessage.contains('503'))
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            improveEmail();
                          },
                          child: const Text('Retry'),
                        ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            improvedEmail = '';
                            errorMessage = '';
                          });
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.email),
            )
          : null,
    );
    
  }
}
