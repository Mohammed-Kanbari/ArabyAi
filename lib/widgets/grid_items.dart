import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String text; // Text to display
  final String imageAsset; // Path to the image asset
  final VoidCallback? onTap; // Function to execute when tapped

  const GridItem({
    Key? key,
    required this.text, // Make text required
    required this.imageAsset, // Make imageAsset required
    this.onTap, // Optional onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shadow and content
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 178,
            height: 178,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(108, 245, 242, 242),
                  spreadRadius: 10,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imageAsset,
                  width: 58,
                  height: 64,
                ),
                Text(
                  textAlign: TextAlign.center,
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
        // Ripple effect
        Positioned.fill(
          child: Material(
            color: Colors.transparent, // Transparent color to avoid hiding the shadow
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onTap, // Execute the tap action
              splashColor: Colors.blue.withOpacity(0.3), // Ripple effect color
              highlightColor: Colors.blue.withOpacity(0.1), // Highlight color
            ),
          ),
        ),
      ],
    );
  }
}
