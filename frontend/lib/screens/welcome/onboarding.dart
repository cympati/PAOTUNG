import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paotung_frontend/screens/welcome/contenr_model.dart';
import 'package:paotung_frontend/screens/main/dashborad.dart';

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
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 80, left: 40, right: 40),
            width: double.infinity,
            child: FlatButton(
              child: Text(
                currentIndex == contents.length - 1 ? "Get Started" : "Next",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Dashboard(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              color: currentIndex == contents.length - 1
                  ? Color.fromRGBO(34, 176, 126, 1)
                  : Color.fromRGBO(230, 234, 242, 1),
              textColor: currentIndex == contents.length - 1
                  ? Colors.white
                  : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
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
        color: currentIndex == index
            ? Color.fromRGBO(34, 176, 126, 1)
            : Color.fromRGBO(230, 234, 242, 1),
      ),
    );
  }
}
