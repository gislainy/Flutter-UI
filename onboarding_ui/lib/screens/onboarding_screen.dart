import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding_ui/utilities/styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9
              ],
                  colors: [
                Color(0xff3594dd),
                Color(0xff4563db),
                Color(0xff5036d5),
                Color(0xff5b16d0),
              ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      print('Skip');
                    },
                    child: Text('Skip',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                Container(
                  height: 500,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    controller: _pageController,
                    children: <Widget>[
                      pageItem(
                          imagePath: 'assets/images/onboarding0.png',
                          title: 'Connect people\naround the world',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                      pageItem(
                          imagePath: 'assets/images/onboarding1.png',
                          title: 'Live your life smarter\nwith us!',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                      pageItem(
                          imagePath: 'assets/images/onboarding2.png',
                          title: 'Get a new experience\nof imagination',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text('')
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? GestureDetector(
              onTap: () {
                print('get started');
              },
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                          color: Color(0xff5b16d0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }

  Widget pageItem({String imagePath, String title, String subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(imagePath),
              height: 200,
              width: 200,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('Connect people\naround the world', style: kTitleStyle),
          SizedBox(
            height: 15,
          ),
          Text(subtitle, style: kSubtitleStyle),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(indicator(i == _currentPage));
    }

    return list;
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8.0,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xff7b5103),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
