import 'package:flutter/material.dart';
import 'package:kfccheck/login.dart';
import 'package:kfccheck/res/const.dart';

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
        width: double.infinity,
        child: Stack(
          children: [
            Column(
            children:const [
              Image(image: AssetImage('asset/QAA.png')),
              Expanded(
                child: Text(
                  'Quality is a trait that we navigate',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),

              Image(image: AssetImage('asset/rectangle.png')),
                ]),
          const Positioned(
              left: 90,
                bottom: 170,
                child: Image(image: AssetImage('asset/Mask_group.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 189,top: 676),
              child: Row(
                children: [
                  InkWell(
                      child:const Text('Get Started',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: black),
                      ),
                     onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                     },
                  ),
                 const Icon(Icons.arrow_forward)
                ],
              ),
            ),
                    ],
          ),
        ),
      ));

  }
}
