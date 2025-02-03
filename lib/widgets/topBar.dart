import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_araby_ai/core/app_colors.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:my_araby_ai/menu/menu.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key});

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => Menu(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Start from the right
                    const end = Offset.zero; // End at the center
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: SvgPicture.asset(AppPhoto.menu),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              width: 290,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 4),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Looking for something..',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ),
          Stack(
            children: [
              SvgPicture.asset(AppPhoto.notication),
              Positioned(
                left: 14,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}