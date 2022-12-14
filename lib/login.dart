import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/res/static_info.dart';
import 'package:kfccheck/screens/qa_walk.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final User = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  bool isShow = false;
  bool check = false;
TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

  userLogin() async {
    isLoading = true;
    setState(() {});
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance.collection(StaticInfo.users).where('email', isEqualTo: nameController.text).get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult =
            await FirebaseFirestore.instance.collection(StaticInfo.users).where('password', isEqualTo: passwordController.text).get();
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
             child: Column(
               children: [
                 Image(image: AssetImage('asset/QA-icon.png', ), height: 150,width: 200, fit: BoxFit.cover,),
                   SizedBox(height: 120),
                 Row(

                children:const [
                 Text('Welcome Back!',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500,color: kBoldColor),
                  textAlign: TextAlign.start,
                ),

              ],),
                 Row(
                   children:const [
                      Text('Enter your account details.',style: TextStyle(fontSize:16,fontWeight: FontWeight.w400,color: lGrey)),
                   ],
                 ),
               const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                   TextFormField(
                     controller: nameController,
                      decoration:const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: lGrey),
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

                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: lGrey),
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isShow= !isShow;
                                });
                              },
                              child: Icon(isShow?Icons.visibility:Icons.visibility_off))
                      ),
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
                       const Expanded(
                            child: Text('Keep me logged in',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: lGrey),)),
                        const Text('Forgot Password?',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: kBoldColor),),
                      ],
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(formKey.currentState!.validate()){
                          userLogin();

                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>QA_walk()));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration:const BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(8)),color: black ),
                        child:const Center(child: Text('Log In',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: yellow))),
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


