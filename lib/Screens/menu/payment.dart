import 'package:flutter/material.dart';
import 'package:my_araby_ai/core/constatns.dart';

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
              height: 246,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/cardimage.png',
                width: 200,
                height: 200,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cardHolderName,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 100),
                    Text(
                      cardNumber,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins'),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment(-0.8, 0),
                      child: Image.asset(
                        logoPath,
                        width: 58,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Set as a primary payment",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
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
            kGap30,
            Expanded(
              child: ListView(
                children: [
                  _buildPaymentCard(
                    "CARD HOLDER FULL NAME",
                    "123 ********8790",
                    "assets/images/visa.png",
                    const Color.fromARGB(255, 103, 164, 230),
                    isPrimary1,
                    (value) {
                      setState(() {
                        isPrimary1 = value;
                        isPrimary2 = !value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
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
                  Color.fromARGB(255, 71, 201, 252),
                  Color.fromARGB(255, 0, 132, 252)
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                height: 45,
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
              ),
            ),
            kGap15,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Have a problem? ",
                style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(201, 49, 47, 47),
                    fontFamily: 'Poppins'),
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    ' Contact us',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 108, 213, 240),
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
