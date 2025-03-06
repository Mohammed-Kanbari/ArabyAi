import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:flutter/services.dart'; // For Clipboard

class FB_Status extends StatefulWidget {
  final List<String> generatedStatuses;
  final bool isError;

  const FB_Status(
      {super.key, required this.generatedStatuses, this.isError = false});

  @override
  State<FB_Status> createState() => _FB_StatusState();
}

class _FB_StatusState extends State<FB_Status> {
  // Calculate word count
  int getWordCount(String text) {
    if (text.isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Status copied to clipboard!',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Build a single status container
  Widget buildStatusContainer(
      String status, double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        width: screenWidth * 0.83,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: widget.isError ? Colors.red : Colors.black87,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${getWordCount(status)} words',
                  style: TextStyle(
                    color: const Color(0xFF757575),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () => _copyToClipboard(status),
                  child: Image.asset(
                    'assets/images/ph_copy.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                    ),
                    Text(
                      'Facebook Status',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                kGap25,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: widget.generatedStatuses
                          .map((status) => buildStatusContainer(
                              status, screenWidth, screenHeight))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
