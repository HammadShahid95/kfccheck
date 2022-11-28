import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/test.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfccheck/models/question_model.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/comment_screen.dart';
import 'package:kfccheck/screens/inspection_areas.dart';
import 'package:kfccheck/screens/roles.dart';
import 'package:kfccheck/screens/sources.dart';

import 'documentation.dart';

class Hygeine extends StatefulWidget {
  const Hygeine({super.key});

  @override
  State<Hygeine> createState() => _HygeineState();
}

class _HygeineState extends State<Hygeine> {
  final TextEditingController nameController = TextEditingController();
  bool isFieldShow = false;
  List<QuestionModel> questions = [
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question:
            'Team member must not be observed  working with symptoms of illness or infection?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Team members meet grooming and personal hygeine standards?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question:
            'Drinking,eating and smoking use only in designated non-food areas?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Gloves and blue bandages available in the restaurant?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question:
            'Proper hair Nets and Beard Mask (if required)  worn by all team members and visitors before entering operations area?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'No jewelry worn when handling food?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question:
            'Proper hand-washing observed when required. (FS-Critical) (Wash, Rinse, Dry, Sanitize)?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Proper hand-washing procedures followed?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question:
            'Proper disposable gloves and blue bandage procedures followed?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Hand washing sink used only for hand washing?'),
  ];
  File? imageFile;
  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  CollectionReference users = FirebaseFirestore.instance.collection('practices');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          SingleChildScrollView(
            child: Column(children: [
              Stack(children: [
                Container(
                  width: 374,
                  height: 204,
                  decoration: const BoxDecoration(color: black),
                  child: Padding(
                    padding:const EdgeInsets.only(left: 10,bottom: 80),
                    child: Row(
                      children: [
                        InkWell(
                          child:const Icon(Icons.arrow_back_ios, color: white),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Inspection()));
                          },
                        ),
                       const Text(
                          'Hygeine Practices',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Dgreen),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Container(
                      width: 374,
                      height: 580,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: gray,
                      ),
                      child:FutureBuilder<DocumentSnapshot>(
                        future: users.doc("BE2oWA5K7EJIWuYeEILR").get(),
                        builder:
                            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState == ConnectionState.done) {
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                            return ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (Context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)),
                                      elevation: 0,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              data['ips'][index]['question'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Sblack),
                                            ),
                                            Row(
                                              children: [
                                                Theme(
                                                  data: Theme.of(context).copyWith(
                                                    unselectedWidgetColor: Colors.grey[500],
                                                  ),
                                                  child:Checkbox(
                                                    value: questions[index].selectedAnswer?.toLowerCase()=='yes' ,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        questions[index].selectedAnswer='yes' ;
                                                      });
                                                    },
                                                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                  ),
                                                ),
                                                const Text('Yes',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black)),

                                                Theme(
                                                  data: Theme.of(context).copyWith(
                                                    unselectedWidgetColor: Colors.grey[500],
                                                  ),
                                                  child:Checkbox(
                                                    value:  questions[index].selectedAnswer?.toLowerCase()=='no',
                                                    onChanged: (value) {
                                                      setState(() {
                                                        questions[index].selectedAnswer='no' ;
                                                      });
                                                    },
                                                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                  ),
                                                ),
                                                const  Text('No',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                                                ),

                                                Theme(
                                                  data: Theme.of(context).copyWith(
                                                    unselectedWidgetColor: Colors.grey[500],
                                                  ),
                                                  child:Checkbox(
                                                    value:  questions[index].selectedAnswer?.toLowerCase()=='n/a' ,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        questions[index].selectedAnswer='n/a' ;
                                                      });
                                                    },
                                                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                  ),
                                                ),
                                                const  Text('N/A',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                                                ),

                                                Theme(
                                                  data: Theme.of(context).copyWith(
                                                    unselectedWidgetColor: Colors.grey[500],
                                                  ),
                                                  child:Checkbox(
                                                    value:  questions[index].selectedAnswer?.toLowerCase()=='n/o' ,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        questions[index].selectedAnswer='n/o' ;
                                                      });
                                                    },
                                                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                  ),
                                                ),
                                                const  Text('N/O',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    width: 67,
                                                    height: 20,
                                                    decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Silver
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children:const [
                                                        Icon(Icons.person,color: white,size: 15),
                                                        Center(child: Text('Task',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: white),))
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Roles()));
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 67,
                                                  height: 20,
                                                  decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Silver
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          getFromCamera();
                                                        },
                                                        child: Icon(Icons.camera_alt_outlined,color: white,size: 15),

                                                      ),
                                                      Text('Image',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: white),)
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    width: 67,
                                                    height: 20,
                                                    decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Silver
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children:const [
                                                        Icon(Icons.message,color: white,size: 15),
                                                        Text('Notes',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: white),),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentsScreen()));
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                            //Text(" ${data['ipname']} ");

                          }

                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const [
                              Text("loading...."),
                              SizedBox(height: 10,),
                              CircularProgressIndicator(),
                            ],
                          ));
                        },
                      ),
                    ),
                  ),
                ),
              ])
            ]),
          ),
        ]),
      ),
    );
  }
}
