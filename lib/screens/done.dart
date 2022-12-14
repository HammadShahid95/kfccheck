import 'package:flutter/material.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/admindashboard.dart';
import 'package:kfccheck/screens/qa_walk.dart';

class Done extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: white,
     body: SafeArea(
    child: Column(
         children: [
           Expanded(
             child: Container(
               width: 375,
               height: 812,
               color: lwhite,
               child: Column(
                   children: [
                  const Padding(
                     padding:  EdgeInsets.only(top: 80),
                     child:   Image(image: AssetImage('asset/Done.png')),
                   ),
                    const SizedBox(
                       height: 50,
                     ),
                    const Center(child: Text('Well Done!',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Dgreen))),
                   const Padding(
                      padding:  EdgeInsets.only(left: 15,right: 15,top: 30),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('You have succesfully completed\nthe QA Walk',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: black,
                        ),
                           textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                      Padding(
                        padding:const EdgeInsets.only(top: 200,left: 260),
                        child: InkWell(child:const Image(image: AssetImage('asset/forward.png'),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QA_walk()));
                        },
                        ),
                      )
                   ],
               ),
             ),
           ),
         ],
       )
     ));
  }
}