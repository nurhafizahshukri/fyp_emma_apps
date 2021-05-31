import 'package:EMMA/pages/Signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Onboard extends StatefulWidget {
  Onboard({Key key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
 final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white :  Colors.red[200],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                 Colors.red,
                 Colors.red[800],
                 Colors.red[600],
                 Colors.red[400],
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () =>  _signInWithEmail(context),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding0.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Manage your event\nsmoothly',
                              style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'CM Sans Serif',
                                        fontSize: 26.0,
                                        height: 1.5,
                                        ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'No more hassle on promoting events or \ngenerate event report',
                              style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        height: 1.2,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding1.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Partipating in any event\nyou love!',
                              style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'CM Sans Serif',
                                        fontSize: 26.0,
                                        height: 1.5,
                                        ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'You can simply browse all events that \nyou liked and register with one tap',
                              style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        height: 1.2,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding2.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Get a new experience\nof event management',
                              style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'CM Sans Serif',
                                        fontSize: 26.0,
                                        height: 1.5,
                                        ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'A one stop platform for organizers and participants',
                              style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        height: 1.2,
                                      ),
                            ),
                          ],
                        ),
                      ),
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
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
    ),
          bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () =>  _signInWithEmail(context),
            
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color:  Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }


}
