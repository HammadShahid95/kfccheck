import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfccheck/crud/add_user.dart';
import 'package:kfccheck/screens/admindashboard.dart';
import 'package:kfccheck/screens/done.dart';
import 'package:kfccheck/screens/pest.dart';
import 'package:kfccheck/screens/qa_walk.dart';
import 'package:kfccheck/screens/sanitation.dart';
import 'package:kfccheck/screens/sources.dart';
import 'package:kfccheck/screens/tempraturecontrol.dart';
import 'screens/Sewage.dart';
import 'screens/branches.dart';
import 'screens/chemicals.dart';
import 'screens/contamination.dart';
import 'screens/documentation.dart';
import 'screens/equipement.dart';
import 'screens/hygeine.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KFC Inspection',
      theme: ThemeData(
        fontFamily: 'sofiapro',
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      routes: {
        // '/': (context) => SplashScreen(),
        '/second': (context) => const QA_walk(),
        '/third': (context) => Branches(),
        '/fourth': (context) => const Documentation(),
        '/fifth': (context) => const Hygeine(),
        '/sixth': (context) => const Sources(),
        '/seventh': (context) => const Contamination(),
        '/eight': (context) => const Sanitaiton(),
        '/ninth': (context) => const Temprature(),
        '/tenth': (context) => const Equipment(),
        '/eleventh': (context) => const Chemical(),
        '/twelwth': (context) => const Pest(),
        '/thirteenth': (context) => const Sewage(),
        '/fourtenth': (context) => Done(),
        '/fifteenth': (context) => Admin(),
      },
      home: AddUserPage(),
    );
  }
}
