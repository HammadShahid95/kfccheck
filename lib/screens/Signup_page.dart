import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/login.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/res/static_info.dart';
import 'package:kfccheck/screens/qa_walk.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final User = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  bool isShow = false;
  bool check = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  void getValues() async {
    nameController.text = await getValue("Name");
    emailController.text = await getValue("Email");
  }

  Future<void> save(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String> getValue(String key) async {
    return await secureStorage.read(key: key) ?? "";
  }

  void saveDetails() {
    save("Name", nameController.text);
    save("Email", emailController.text);
  }

  registerEmail() async {
    isLoading = true;
    setState(() {});
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance.collection(StaticInfo.users).where('email', isEqualTo: emailController.text).get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await FirebaseFirestore.instance.collection(StaticInfo.users).where('password', isEqualTo: passwordController.text).get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Successfully logged in');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QA_walk()),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                key: formKey,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Image(
                      image: AssetImage(
                        'asset/QA-icon.png',
                      ),
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Sign Up!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: kBoldColor),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: emailController,
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
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter First Name';
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
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: black),
                                child:
                                    const Center(child: Text('Sign Up', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: yellow))),
                              ),
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  registerEmail();

                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>QA_walk()));
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: lGrey),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kala),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
