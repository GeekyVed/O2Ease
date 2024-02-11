import 'package:o2ease/constants/colors.dart';
import 'package:o2ease/screens/auth_part/login.dart';
import 'package:flutter/material.dart';
import 'package:o2ease/screens/navbar.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.background,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              }, 
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.color,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: const [
              createPage(
                image: 'assets/images/image1.jpg',
                title: "Real Time Pollution Updates",
                description: "Stay Informed about air quality in your area with live updates.",
              ),
              createPage(
                image: 'assets/images/image2.jpg',
                title: "Interactive Gamified Exercises",
                description: "Engage in fun games designed to improve breathing techniques",
              ),
              createPage(
                image: 'assets/images/image3.jpg',
                title: "Personalized Results",
                description: "Personalized Reminders and alerts for your medical help",
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex < 2) {
                        currentIndex++;
                        if (currentIndex < 3) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const RootPage()));
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: Colors.white,
                  )),
              padding: const EdgeInsets.all(4),
              decoration:const BoxDecoration(
                shape: BoxShape.circle,
                
                gradient: LinearGradient(colors: AppColors.gradient),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor1,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class createPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const createPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset(image),
          ),
          const SizedBox(
            height: 20,
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: AppColors.gradient, // Gradient colors
                begin: Alignment.centerLeft, // Gradient start point
                end: Alignment.centerRight, // Gradient end point
              ).createShader(bounds);
            },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style:const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}