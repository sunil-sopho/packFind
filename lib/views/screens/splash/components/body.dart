// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:pack/views/screens/sign_in/sign_in_screen.dart';
import 'package:pack/views/widgets/common.dart';
import 'package:pack/views/routes/routes.gr.dart';

// This is the best practice
import 'package:pack/config/constants.dart';
import 'package:pack/controllers/utils.dart';
import '../components/splash_content.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() async {
    // if (FirebaseAuth.instance.currentUser != null) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => Screen1()));
    // } else {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LoginPage()));
    // }
  }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to PackFND!",
      "des": "OH !! where is ...",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "SECURE AND SOUND",
      "des": "You can store items and forget, We will make sure to remmember",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "EASILY AND QUICKLY",
      "des": "Fetch them at 1 click with keywords or QR",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  // image: splashData[index]["image"],
                  text: splashData[index]['text']!,
                  des: splashData[index]['des']!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        // print("btn pressed");
                        context.router.pop();
                        context.router.pushNamed('/sign-in-screen');
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
