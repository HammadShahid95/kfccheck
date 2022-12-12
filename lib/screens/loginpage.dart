import 'package:flutter/material.dart';
import 'package:kfccheck/login.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/adminlogin.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Image(
                  image: AssetImage(
                    'asset/QA-icon.png',
                  ),
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50, right: 140),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kBoldColor),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  child: Container(
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)), color: white, border: Border.all(color: lGrey)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Image(image: AssetImage('asset/admin img.png')),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Log In as Admin',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: DBlack),
                        )
                      ],
                    ),
                  ),
                  onTap: (() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  child: Container(
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)), color: white, border: Border.all(color: lGrey)),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Image(image: AssetImage('asset/team member img.png')),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Log In as Team Member',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: DBlack),
                        )
                      ],
                    ),
                  ),
                  onTap: (() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  }),
                ),
              ),
            ],
          ),
        )));
  }
}
