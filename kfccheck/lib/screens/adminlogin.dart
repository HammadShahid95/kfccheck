import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/res/static_info.dart';
import 'package:kfccheck/screens/Signup_page.dart';
import 'package:kfccheck/screens/admindashboard.dart';
import 'package:kfccheck/screens/qa_walk.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final Aadmin = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  bool isShow = false;
  bool check = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernamecontroler = TextEditingController();

  userLogin() async {
    print("start");
    isLoading = true;
    setState(() {});
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance.collection(StaticInfo.admin).where('email', isEqualTo: nameController.text).get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await FirebaseFirestore.instance.collection(StaticInfo.admin).where('password', isEqualTo: passwordController.text).get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Successfully logged in');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Admin()),
          );
        } else {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Incorrect email or password');
        }
      } else {
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Incorrect email or password');
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(children: [
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
            const SizedBox(height: 60),
            Row(
              children: const [
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kBoldColor),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              children: const [
                Text('Enter your account details.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter UserName';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isShow,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isShow = !isShow;
                              });
                            },
                            child: Icon(isShow ? Icons.visibility : Icons.visibility_off))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter password';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: check,
                        onChanged: (value) {
                          setState(() {
                            check = !check;
                          });
                        },
                      ),
                      const Text(
                        'Keep me logged in',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lGrey),
                      ),
                      const Spacer(),
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kBoldColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        userLogin();

                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>QA_walk()));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: black),
                      child: const Center(child: Text('Log In', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: yellow))),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: lGrey),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
                    },
                    child: const Text("Sign up"))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
