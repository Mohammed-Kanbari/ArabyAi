import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_araby_ai/core/constatns.dart';
import 'package:my_araby_ai/widgets/topBar.dart';
import 'package:http/http.dart' as http;

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

  bool isLoading = false;
  Uint8List? imageBytes;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Initialize all tags as unselected
    for (var tag in tags) {
      selectedTags[tag] = false;
    }

    //Add listener to update button state when the text changes
    _promptController.addListener(() {
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

  //API call to generate image
  Future<void> generateImage() async {
    if (!isButtononEnabled || isLoading) return;

    setState(() {
      isLoading = true;
      imageBytes = null;
      errorMessage = '';
    });

    try {
      const String apiToken = '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';
      final String fullPrompt = _promptController.text +
          (selectedTags.values.contains(true)
              ? ', ' +
                  selectedTags.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .join(', ')
              : '');

      final response = await http.post(
        Uri.parse(
            'https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0'),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'inputs': fullPrompt,
          // Optional parameters (adjust as needed)
          'parameters': {
            'num_inference_steps': 50,
            'guidance_scale': 7.5,
          },
        }),
      );
      print('Status ${response.statusCode}');
      print(
          'Body length: ${response.bodyBytes.length} bytes'); // Log size for debugging

      if (response.statusCode == 200) {
        setState(() {
          imageBytes = response.bodyBytes; // Store raw bytes
          isLoading = false;
        });
      } else {
        final errorBody =
            response.body.isNotEmpty ? jsonDecode(response.body) : {};
        setState(() {
          errorMessage =
              'Failed to generate image: ${response.statusCode} - ${errorBody['error'] ?? 'Unknown error'}';
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(16, 0, 0, 0)
                          .withOpacity(0.25), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 16, // Blur radius
                      offset: Offset(0, 4), // Shadow direction (x, y)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
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
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Describe what is on your mind. For best results, be specific..',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                          kGap10,
                          SizedBox(
                            height: 140.h,
                            child: TextField(
                              controller: _promptController,
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: true,
                              style: TextStyle(fontSize: 16.sp),
                              decoration: InputDecoration(
                                  hintText:
                                      'Example: A car flying in the space',
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
                                  contentPadding: EdgeInsets.all(10)),
                            ),
                          ),
                          kGap10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Need some help ?',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(255, 121, 121, 121)),
                              ),
                              OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      iconSize: 20.sp,
                                      backgroundColor:
                                          Color.fromARGB(255, 199, 161, 255),
                                      side: BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/svg/atom.svg'),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Auto Generate',
                                        style: TextStyle(
                                            fontSize: 12.sp,
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
                      spacing: 8.sp,
                      runSpacing: -6.sp,
                      children: tags.map((tag) {
                        return ChoiceChip(
                          label: Text(
                            tag,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          selected: selectedTags[tag] ?? false,
                          onSelected: (isSelected) {
                            setState(() {
                              selectedTags[tag] = isSelected;
                            });
                          },
                          selectedColor: Colors.blue.shade100,
                          backgroundColor:
                              const Color.fromARGB(255, 245, 245, 245),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: selectedTags[tag] == true
                                      ? Colors.blue
                                      : const Color.fromARGB(
                                          255, 248, 248, 248))),
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
        bottomNavigationBar: Container(
          width: 100.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(15, 0, 0, 0)
                    .withOpacity(0.25), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 16, // Blur radius
                offset: Offset(0, 4), // Shadow direction (x, y)
              ),
            ],
          ),
          child: Center(
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: isButtononEnabled
                    ? BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF3CC8EB), Color(0xFF1171D8)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(10))
                    : BoxDecoration(
                        color: const Color.fromARGB(0, 238, 238, 238),
                        borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: isButtononEnabled ? generateImage : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Generate Image',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: isButtononEnabled
                                  ? Colors.white
                                  : const Color.fromARGB(178, 206, 195, 195)),
                        ),
                )),
          ),
        ),
        floatingActionButton: imageBytes != null || errorMessage.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (imageBytes != null)
                              SizedBox(
                                width: 300.w, // Adjust width
                                height: 300.h, // Adjust height
                                child: Image.memory(imageBytes!),
                              ),
                            if (errorMessage.isNotEmpty)
                              Text(errorMessage),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              imageBytes = null;
                              errorMessage = '';
                            });
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(Icons.image),
              )
            : null,
      ),
    );
  }
}