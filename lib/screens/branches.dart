import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/inspection_areas.dart';
import 'package:kfccheck/screens/report_emergency.dart';
import 'package:kfccheck/screens/roles.dart';

import 'documentation.dart';

class Branches extends StatefulWidget {
  @override
  State<Branches> createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  List<String> location = [
    'KFC\nJohar Town',
    'KFC\nTownship',
    'KFC\nDHA',
    'KFC\nGulberg',
    'KFC\nBahria Town',
    'KFC\nEmporium Mall'
  ];
  List<int> answerss = [
    1,2,3,4,5,6
  ];

  showAlertDialog(BuildContext context) {

    AlertDialog alert = AlertDialog(
      title: Text("Do you want to report an emergency",textAlign: TextAlign.center,),
      actions: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  width: 151,
                  height: 48,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: GRay),
                  child: Center(child: Text('No Report',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: white),)),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Inspection()));
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  width: 151,
                  height: 48,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: Black),
                  child: Center(child: Text('Report',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Dgreen),)),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Report()));
                },
              ),
            ),
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  int groupValue = -1;
  bool isfalse = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
           children: [
             Stack(
               children:[ Container(
                 width: 414,
                 height: 204,
                 decoration:const BoxDecoration(color: kala),
                 child:const Padding(
                   padding:  EdgeInsets.only(top: 60,left: 10),
                   child: Text('Branches',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Dgreen),),
                 ),
               ),
                 Positioned(child:
                 Padding(
                   padding: const EdgeInsets.only(top: 120),
                   child: Container(
                   width: 414,
                     height: 539,
                     decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: gray,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 15),
                       child: Column(
                         children: [
                          const SizedBox(
                             height: 20,
                           ),
                           ListView.builder(
                             shrinkWrap: true,
                               itemCount: location.length,
                               itemBuilder: (context, index){
                             return  GestureDetector(
                               onTap: (){
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                               },
                               child: Card(
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                 elevation: 0,
                                 color: Colors.white,
                                 child:  ListTile(
                                   leading:const Image(image: AssetImage('asset/Vector.png')),
                                   title: Text(location[index],style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack),),
                                   trailing: Radio<int>(
                                     value: answerss[index]!,
                                     groupValue: groupValue,
                                     activeColor: GREEN,
                                     onChanged: (value) {
                                       setState(() {
                                         groupValue = value!;

                                       });
                                       Timer(Duration(seconds: 1), () =>    groupValue != -1? showAlertDialog(context):Container());
                                       },
                                   ),
                                 ),
                               ),
                             );
                           }),

                         ],
                       ),
                     ),
                 ),
                 ),
                 )]),
           ],

          ),

      ),
    );
  }
}
