import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:getter/getter.dart';
import 'package:kfccheck/res/const.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonenumberController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phonenumberController.dispose();
  }

  clearText() {
    firstnameController.clear();
    lastnameController.clear();
    emailController.clear();
    passwordController.clear();
    phonenumberController.clear();
  }

  bool isLoading = false;

  CollectionReference User = FirebaseFirestore.instance.collection('users');

  Future addUser() async {
    setState(() {
      isLoading = true;
    });
    UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    await User.doc(user.user?.uid).set({
      'firstName': firstnameController.text,
      'lastName': lastnameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phonenumber': phonenumberController.text,
      'isApproved': true,
      'role': 'teammember'
    });
    var email = await secureStorage.read(key: 'Email');
    var password = await secureStorage.read(key: 'Password');
    if (email != null && password != null) {
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }
    setState(() {
      isLoading = false;
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 204,
                    width: 414,
                    decoration: const BoxDecoration(color: black),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        'User',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        height: 640,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(19)), color: grayish),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'First Name',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), color: white, border: Border.all(color: white)),
                                child: TextFormField(
                                  controller: firstnameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter First Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Last Name',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(7)), color: white, border: Border.all(color: greyish)),
                                child: TextFormField(
                                  controller: lastnameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Last Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Email',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), color: white, border: Border.all(color: white)),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Last Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Role',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 55,
                                width: 339,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                    color: white,
                                    border: Border.all(color: Color.fromRGBO(239, 235, 235, 1))),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                    hintText: 'Role',
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: lGrey),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Phone Number',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                                        hintText: '+92',
                                        hintStyle: TextStyle(color: lGrey),
                                        constraints: BoxConstraints.tightFor(
                                          width: 80,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                                        hintText: '324 675 8766',
                                        hintStyle: TextStyle(color: lGrey),
                                        constraints: BoxConstraints.tightFor(
                                          width: 230,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                child: Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: black),
                                  child: const Center(
                                    child: Text(
                                      'Add User',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Dgreen),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    addUser();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
