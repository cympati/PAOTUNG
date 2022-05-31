import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/welcome/content_model.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';

import '../start/sign_up/sign_up.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 120, bottom: 0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          RoundedButton(
              text:
                  currentIndex == contents.length - 1 ? "Get Started" : "Next",
              bottom: 100,
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacementNamed(context, '/register');
                }
                _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              color: currentIndex == contents.length - 1
                  ? AppColors.mainColor
                  : AppColors.lightgrey,
              textColor: currentIndex == contents.length - 1
                  ? Colors.white
                  : Colors.black)
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 10 : 10,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            currentIndex == index ? AppColors.mainColor : AppColors.lightgrey,
      ),
    );
  }
}
