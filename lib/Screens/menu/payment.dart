import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Widget _buildPaymentCard(
    String cardHolderName,
    String cardNumber,
    String logoPath,
    Color cardColor,
    bool isPrimary,
    Function(bool) onToggle,
  ) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 246.h,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/cardimage.png',
                width: 200.w,
                height: 200.h,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,                  
                  children: [
                    Text(
                      cardHolderName,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  Spacer(),
                    Text(
                      cardNumber,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 10.h,),
                    Align(
                      alignment: Alignment(-0.8, 0),
                      child: Image.asset(
                        logoPath,
                        width: 58.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Set as a primary payment",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp),
            ),
            Switch(
              value: isPrimary,
              onChanged: onToggle,

              activeColor: const Color.fromARGB(
                  255, 255, 255, 255), // Switch color when active (Annual)
              inactiveThumbColor:
                  Colors.grey, // Switch thumb color when inactive (Monthly)
              inactiveTrackColor: Colors.grey[300], // Track color when inactive
              activeTrackColor: const Color(0xFF3CC8EB), //
            ),
          ],
        ),
      ],
    );
  }

  bool isPrimary1 = true; // Toggle for first card
  bool isPrimary2 = false; // Toggle for second card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 3),
        child: Column(
          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
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
            SizedBox(height: 30.h),
            Expanded(
              child: ListView(
                children: [
                  _buildPaymentCard(
                    "CARD HOLDER FULL NAME",
                    "123 ********8790",
                    "assets/images/visa.png",
                    const Color(0xFF67A4E6),
                    isPrimary1,
                    (value) {
                      setState(() {
                        isPrimary1 = value;
                        isPrimary2 = !value;
                      });
                    },
                  ),
                  SizedBox(height: 30.h),
                  _buildPaymentCard(
                    "CARD HOLDER FULL NAME",
                    "123 ********8790",
                    "assets/images/mastercard.png",
                    const Color(0xFF82dcf2),
                    isPrimary2,
                    (value) {
                      setState(() {
                        isPrimary2 = value;
                        isPrimary1 = !value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [
                  Color(0xFF3CC8EB),
                  Color(0xFF1171D8)
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                height: 45.h,
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins',
                      fontSize: 14.sp),
                ),
              ),
            ),
            kGap15,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Have a problem? ",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF757575),
                    fontFamily: 'Poppins'),
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    ' Contact us',
                    style: TextStyle(
                      fontSize: 14.sp,
                        color: const Color(0xFF3CC8EB),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins'),
                  )),
            ]),
          ],
        ),
      )),
    );
  }
}
