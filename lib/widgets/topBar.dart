import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_araby_ai/core/app_colors.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:my_araby_ai/Screens/menu/menu.dart';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Menu()));
            },
            child: SvgPicture.asset(AppPhoto.menu)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  width: 284.w,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        prefixIcon: Icon(Icons.search, color: const Color(0xFFC7C7C7),),
                        hintText: 'Looking for something..',
                        hintStyle: TextStyle(
                          color: const Color(0xFFC7C7C7),
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
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
                    backgroundColor: AppColors.purple,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
