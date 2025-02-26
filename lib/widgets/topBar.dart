import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_araby_ai/Screens/type_of_contents/Email%20Page/E-mails_page.dart';
import 'package:my_araby_ai/Screens/type_of_contents/Email%20Page/imrpve_email.dart';
import 'package:my_araby_ai/Screens/type_of_contents/SocailM%20Page/sm_facebook.dart';
import 'package:my_araby_ai/Screens/type_of_contents/SocailM%20Page/sm_main.dart';
import 'package:my_araby_ai/Screens/type_of_contents/images_page.dart';
import 'package:my_araby_ai/core/app_colors.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:my_araby_ai/Screens/menu/menu.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key});

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _options = [
    'Image generating',
    'Social media creation',
    'Facebook status',
    'Email creation',
    'Improve your email'
  ];
  List<String> _filteredOptions = [];
  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    _filteredOptions = _options;
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_searchFocusNode.hasFocus) {
      setState(() {
        _showOptions = false;
      });
    }
  }

  void _filterOptions(String query) {
    setState(() {
      _filteredOptions = _options
          .where((option) => option.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _showOptions = query.isNotEmpty && _filteredOptions.isNotEmpty;
    });
  }

  void _navigateToPage(String option) {
    switch (option) {
      case 'Image generating':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Image_Page()));
      case 'Social media creation':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SmMain()));
      case 'Facebook status':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SmFacebook()));
      case 'Email creation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Email_Page()));
      case 'Improve your email':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ImrpveEmail()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Menu(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0); // Start from left
                          const end =
                              Offset.zero; // End at the current position
                          const curve = Curves
                              .easeInOut; // Smooth curve for the animation

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  child: SvgPicture.asset(AppPhoto.menu)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      width: 284.w,
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        onChanged: _filterOptions,
                        onTap: () => setState(() => _showOptions = true),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            prefixIcon: Icon(
                              Icons.search,
                              color: const Color(0xFFC7C7C7),
                            ),
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
          if (_showOptions && _filteredOptions.isNotEmpty)
            Container(
              width: 277.w,
              constraints: BoxConstraints(
                maxHeight: 220.h, // Max height to prevent the container from growing too large
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Scrollbar(
                thickness: 3,
                radius: Radius.circular(5),
                child: ListView.separated(
                  itemCount: _filteredOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _filteredOptions[index],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        _navigateToPage(_filteredOptions[index]);
                        setState(() => _showOptions = false);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.withOpacity(0.3), // Line color
                      thickness: 1, // Line thickness
                      indent: 10, // Indentation from the left
                      endIndent: 10, // Indentation from the right
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }
}