import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_araby_ai/core/app_colors.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/core/photo_link.dart';
import 'package:my_araby_ai/widgets/topBar.dart';

class Image_Page extends StatefulWidget {
  const Image_Page({super.key});

  @override
  State<Image_Page> createState() => _Image_PageState();
}

class _Image_PageState extends State<Image_Page> {
  final List<String> tags = [
    "Portrait",
    "Illustration",
    "Concept art",
    "Texture",
    "Impressionism",
    "Digital art",
    "V-Ray",
    "Full HD",
    "HD",
    "4K",
    "8K",
    "Monochromatic",
    "Ultra-realistic",
    "Soft lighting",
    "3D",
    "Aesthetic",
    "Glitter",
    "High quality",
    "Smooth",
    "Cinematic lighting",
    "Rich colors",
    "Cartoon",
    "colorful",
    "Wallpaper",
    "Artwork",
    "Photography",
    "Background",
    "Asethetic",
  ];




 // Map to track selected state of each tag
  final Map<String, bool> selectedTags = {};

  // Controller to track the text field's input
  final TextEditingController _promptController = TextEditingController();

  //Variable to track the button's enabled/disabled state
  bool isButtononEnabled = false;

  @override
  void initState() {
    super.initState();
    // Initialize all tags as unselected
    for (var tag in tags) {
      selectedTags[tag] = false;
    }

    //Add listener to update button state when the text changes
    _promptController.addListener((){
      setState(() {
        isButtononEnabled = _promptController.text.trim().isNotEmpty;
      });

    });
  }

  @override
  void dispose() {
    super.dispose();

    _promptController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  Material(
                    elevation: 3,
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    child: Column(
                      children: [
                      Topbar(),
                      kGap25,
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Explore AI-generated images',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Describe what is on your mind. For best results, be specific..',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400),
                            ),
                            kGap10,
                            SizedBox(
                              height: 150,
                              child: TextField(
                                controller: _promptController,
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(
                                    hintText:
                                        'Example: A car flying in the space',
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 183, 182, 182),
                                        fontSize: 14),
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
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                            ),
                            kGap10,
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Need some help ?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color:
                                          Color.fromARGB(255, 121, 121, 121)),
                                ),
                                OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        iconSize: 20,
                                        backgroundColor: Color.fromARGB(
                                            255, 199, 161, 255),
                                        side: BorderSide(color: Colors.white),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/svg/atom.svg'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Auto Generate',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      kGap10,
                    ],
                    ),
                  ),
              
              
              
                  kGap15,
                  
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: -6,
                          children: tags.map((tag) {
                            return ChoiceChip(
                              label: Text(tag),
                              selected: selectedTags[tag] ?? false,
                              onSelected: (isSelected){
                                setState(() {
                                  selectedTags[tag] = isSelected;
                                });
                              },
                              selectedColor: Colors.blue.shade100,
                              backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: selectedTags[tag] == true ?  Colors.blue: const Color.fromARGB(255, 248, 248, 248))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 3),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
               
              
                  
              
              
              
                ],
              ),
              ),
      
      
              bottomNavigationBar:  Container(
               width: 100,
               height: 120,
               decoration: BoxDecoration(
      
               color: Colors.white,
               boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 5
                )
               ]
               ),
               child: Center(
                child: Padding(
                  padding: const EdgeInsets.only( top: 25, bottom: 30),
                  child: Container(
                    decoration: isButtononEnabled ? BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 71, 201 , 252), Color.fromARGB(255, 0, 132, 252)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight), 
                        borderRadius: BorderRadius.circular(10)
                    ) : BoxDecoration(
                      color: const Color.fromARGB(0, 238, 238, 238), 
                      borderRadius: BorderRadius.circular(10)
                                  
                    ),
                    child: ElevatedButton(
                      onPressed: isButtononEnabled ? (){
                    
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 130),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      child: Text(
                        'Generate Image',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: isButtononEnabled ? Colors.white 
                          :  const Color.fromARGB(121, 182, 174, 174)
                        ),
                        )
                      ),
                  ),
                  ) 
                ),
              ),
              ),
    );
  
   
  
  
  }


}
