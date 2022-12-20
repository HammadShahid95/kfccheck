import 'package:flutter/material.dart';
import 'package:kfccheck/login.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/loginpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QA_walk())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(children: [
              const Image(image: AssetImage('asset/QAA.png')),
              const Expanded(
                child: Text(
                  'Quality is a trait that we navigate',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Expanded(
                child: Image(
                  width: MediaQuery.of(context).size.width,
                  image: const AssetImage('asset/rectangle.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ]),
            const Positioned(
              left: 90,
              bottom: 170,
              child: Image(image: AssetImage('asset/Mask_group.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200, top: 696),
              child: GestureDetector(
                child: Row(
                  children: const [
                    Text(
                      'Get Started',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: black),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage()));
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
