import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kfccheck/login.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/admindashboard.dart';
import 'package:kfccheck/screens/approval_page.dart';
import 'package:kfccheck/screens/loginpage.dart';
import 'package:kfccheck/screens/qa_walk.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    verify();
  }

  verify() async {
    var email = await secureStorage.read(key: 'Email');
    var password = await secureStorage.read(key: 'Password');
    if (email != null && password != null) {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (user.user != null) {
        var doc = firebaseFirestore.collection('users').doc(user.user?.uid);
        var data = await doc.get();
        if (data['isApproved'] && data['role'] == 'admin') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Admin()));
        } else if (data['isApproved'] && data['teammember']) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QA_walk()));
        } else if (!data['isApproved']) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ApprovalAwaitPage()));
        }
      }
    }
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
