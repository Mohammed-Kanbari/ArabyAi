import 'package:flutter/material.dart';
import 'package:my_araby_ai/Screens/get_started.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView(
                      controller: _pageController,
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        Widget1(),
                        Widget2(),
                        Widget3(),
                      ],
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: _currentPage == index ? 16 : 12,
                            height: _currentPage == index ? 16 : 12,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color.fromARGB(255, 17, 113, 216)
                                  : const Color.fromARGB(255, 131, 193, 243),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 71, 201, 252),
                        Color.fromARGB(255, 0, 132, 252)
                      ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                           MaterialPageRoute(builder: (context) => GetStarted()),
                           );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        minimumSize: Size(10,
                            4), // Width: 200, Height: 50 // Button background color
                      ),
                      child: Text('GET STARTED',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
              SizedBox(height: 90),
            ],
          ),
        );
      }
    );
  }
}

class Widget1 extends StatelessWidget {
  const Widget1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 190,
              left: 54,
              child: Image.asset(
                'assets/images/GS1.png',
                width: 320,
                height: 250.32,
              )),
          Center(
            child: Align(
              alignment: Alignment(0, 0.7),
              child: Text(
                "Kickstart your content now with simple \nsteps and improve your brand’s voice \nand tone.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Widget2 extends StatelessWidget {
  const Widget2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 190,
              left: 54,
              child: Image.asset(
                'assets/images/GS2.png',
                width: 320,
                height: 250.32,
              )),
          Center(
            child: Align(
              alignment: Alignment(0, 0.7),
              child: Text(
                "Never face writes block again. Generate \ncreative content that aligns with your \nidea.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Widget3 extends StatelessWidget {
  const Widget3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 190,
              left: 54,
              child: Image.asset(
                'assets/images/GS3.png',
                width: 320,
                height: 250.32,
              )),
          Center(
            child: Align(
              alignment: Alignment(0, 0.75),
              child: Text(
                "Build your brand’s voice, get your \nthoughts out to the world and educate \nyour customers without the need for \ndedicated copywriting staff.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
