import 'package:flutter/material.dart';
import 'package:muhaslti/view/LunchScreen.dart';
import 'package:muhaslti/view/NewLoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstLaunchHandler extends StatefulWidget {
  @override
  _FirstLaunchHandlerState createState() => _FirstLaunchHandlerState();
}

class _FirstLaunchHandlerState extends State<FirstLaunchHandler> {
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
    if (isFirstLaunch == null || isFirstLaunch) {
      prefs.setBool('isFirstLaunch', false);
    } else {
      setState(() {
        _isFirstLaunch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLaunch) {
      return LaunchScreensSequence();
    } else {
      return NewLoginPage();
    }
  }
}

class LaunchScreensSequence extends StatefulWidget {
  @override
  _LaunchScreensSequenceState createState() => _LaunchScreensSequenceState();
}

class _LaunchScreensSequenceState extends State<LaunchScreensSequence> {
  final PageController _controller = PageController();
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              LaunchScreen1(),
              LaunchScreen2(),
              LaunchScreen3(),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: currentPage != 2,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewLoginPage()),
                        );
                      },
                      child: Text(
                        'تخطي',
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 16,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.lightBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 17.0),
                  child: currentPage == 2
                      ? TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewLoginPage()),
                            );
                          },
                          child: Text(
                            'الدخول',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            'التالي',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
