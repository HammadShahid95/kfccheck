import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfccheck/models/question_model.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/comment_screen.dart';
import 'package:kfccheck/screens/inspection_areas.dart';
import 'package:kfccheck/screens/roles.dart';
import 'package:kfccheck/screens/tempraturecontrol.dart';

import 'contamination.dart';

class Sanitaiton extends StatefulWidget {
  const Sanitaiton({super.key});

  @override
  State<Sanitaiton> createState() => _SanitaitonState();
}

class _SanitaitonState extends State<Sanitaiton> {
  final TextEditingController nameController = TextEditingController();
  bool isFieldShow = false;
  List<QuestionModel> questions = [
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: "Utensils, smallware's, food contact surfaces are properly cleaned and stored?"),
    QuestionModel(answers: ['Yes', 'No', 'N/A', 'N/O'], comments: '', question: 'Equipment is properly cleaned and free of excess debris, buildup?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'], comments: '', question: 'Three-compartment sink set up correctly and proper cleaning method followed?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'], comments: '', question: 'Hand washing sinks must be accessible, clean and functioning properly?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Wiping cloths used and stored properly in a sanitizer bucket with correct concentration?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Cleaning supplies must be of sufficient availability, capacity, stored and maintained clean?'),
    QuestionModel(answers: ['Yes', 'No', 'N/A', 'N/O'], comments: '', question: 'All non-food contact surfaces are clean and in good repair?'),
    QuestionModel(answers: ['Yes', 'No', 'N/A', 'N/O'], comments: '', question: 'Floors, walls, ceiling are cleanable, clean and in good repair?'),
    QuestionModel(answers: ['Yes', 'No', 'N/A', 'N/O'], comments: '', question: 'Vents and exhaust hoods are clean and in good repair?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'All gaskets on refrigeration/freezer units, ice machines and hot holding units are clean and in good repair?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question:
            'All lighting sources are properly shielded or have shatter proof bulbs in areas where food, service utensils and equipment are stored or prepared?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Trash receptacles in all restrooms and back of house are of sufficient availability, capacity and clean?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Dumpster area is free of debris and odor, maintained clean and in good repair?'),
    QuestionModel(
        answers: ['Yes', 'No', 'N/A', 'N/O'],
        comments: '',
        question: 'Sanitizer at proper concentration in sanitizer sink and test strips available?'),
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

  CollectionReference users = FirebaseFirestore.instance.collection('sanitation');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 204,
                      decoration: const BoxDecoration(color: black),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 80),
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(Icons.arrow_back_ios, color: white),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Inspection()));
                              },
                            ),
                            const Text(
                              'Cleaning/Sanitation',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Container(
                          width: 414,
                          height: 600,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            color: gray,
                          ),
                          child: FutureBuilder<DocumentSnapshot>(
                            future: users.doc("sxlUIPP994kCvrtybTfs").get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                                    itemCount: 14,
                                    itemBuilder: (Context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Sblack),
                                                ),
                                                Row(
                                                  children: [
                                                    Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor: Colors.grey[500],
                                                      ),
                                                      child: Checkbox(
                                                        value: questions[index].selectedAnswer?.toLowerCase() == 'yes',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            questions[index].selectedAnswer = 'yes';
                                                          });
                                                        },
                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                      ),
                                                    ),
                                                    const Text('Yes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Black)),
                                                    Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor: Colors.grey[500],
                                                      ),
                                                      child: Checkbox(
                                                        value: questions[index].selectedAnswer?.toLowerCase() == 'no',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            questions[index].selectedAnswer = 'no';
                                                          });
                                                        },
                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'No',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Black),
                                                    ),
                                                    Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor: Colors.grey[500],
                                                      ),
                                                      child: Checkbox(
                                                        value: questions[index].selectedAnswer?.toLowerCase() == 'n/a',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            questions[index].selectedAnswer = 'n/a';
                                                          });
                                                        },
                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'N/A',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Black),
                                                    ),
                                                    Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor: Colors.grey[500],
                                                      ),
                                                      child: Checkbox(
                                                        value: questions[index].selectedAnswer?.toLowerCase() == 'n/o',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            questions[index].selectedAnswer = 'n/o';
                                                          });
                                                        },
                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'N/O',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Black),
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
                                                        decoration:
                                                            const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Silver),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: const [
                                                            Icon(Icons.person, color: white, size: 15),
                                                            Center(
                                                                child: Text(
                                                              'Task',
                                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: white),
                                                            ))
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Roles()));
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      width: 67,
                                                      height: 20,
                                                      decoration:
                                                          const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Silver),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              getFromCamera();
                                                            },
                                                            child: Icon(Icons.camera_alt_outlined, color: white, size: 15),
                                                          ),
                                                          Text(
                                                            'Image',
                                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: white),
                                                          )
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
                                                        decoration:
                                                            const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Silver),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: const [
                                                            Icon(Icons.message, color: white, size: 15),
                                                            Text(
                                                              'Notes',
                                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsScreen()));
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

                              return Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("loading...."),
                                  SizedBox(
                                    height: 10,
                                  ),
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
            ],
          ),
        ));
  }
}
