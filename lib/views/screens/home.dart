import 'package:flutter/material.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/packFND_4_logo.png',
            width: 300,
            height: 300,
          ),
          ElevatedButton.icon(
              onPressed: () {
                context.router.push(const SplashScreen());
              },
              label: const Text('Login to Find'),
              icon: const Icon(Icons.verified_user_rounded),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          FractionalTranslation(
            translation: const Offset(1.5, 1.5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: const SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.yellow),
                )),
          ),
        ]),
      ]),
    );
  }
}
