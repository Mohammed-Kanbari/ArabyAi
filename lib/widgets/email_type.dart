import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailType extends StatelessWidget {
  final String imagePath;  // Image path to be passed as parameter
  final String text;       // Text to be passed as parameter
  final VoidCallback onTap;  // Function to execute when tapped

  const EmailType({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: onTap, // Trigger the onTap function passed as parameter
      child: Container(
        
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 3), // Adjust the padding as needed
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the container
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Shadow direction (x, y)
            ),
          ],
        ),
        child: LayoutBuilder (builder: (context, constraints) {
          double containerWidth = constraints.maxWidth;
        
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath, // Display image passed as parameter
                width: screenWidth > 650 ? containerWidth * 0.3 : containerWidth * 0.4, // You can adjust the size here
                height: screenWidth > 650 ? containerWidth * 0.3 : containerWidth * 0.4,
              ),
              SizedBox(height: 8.h), // Space between image and text
              Text(
                text, // Display text passed as parameter
                style: TextStyle(
                  fontSize: screenWidth > 650 ? containerWidth * 0.07 : containerWidth * 0.08,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
  }),
      ),
    );
  }
}
