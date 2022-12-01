import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:kfccheck/login.dart';
import 'package:kfccheck/res/const.dart';
import 'package:kfccheck/screens/Sewage.dart';
import 'package:kfccheck/screens/chemicals.dart';
import 'package:kfccheck/screens/contamination.dart';
import 'package:kfccheck/screens/documentation.dart';
import 'package:kfccheck/screens/done.dart';
import 'package:kfccheck/screens/equipement.dart';
import 'package:kfccheck/screens/hygeine.dart';
import 'package:kfccheck/screens/pest.dart';
import 'package:kfccheck/screens/qa_walk.dart';
import 'package:kfccheck/screens/sanitation.dart';
import 'package:kfccheck/screens/sources.dart';
import 'package:kfccheck/screens/tempraturecontrol.dart';


class Inspection extends StatefulWidget {
  const Inspection({Key? key}) : super(key: key);

  @override
  State<Inspection> createState() => _InspectionState();
}

class _InspectionState extends State<Inspection>{
  List<String> areas =[
    'Required Documentation',
    'Hygiene Practices',
    'Approved Source',
    'Protection from Contamination',
    'Cleaning/Sanitation',
    'Time Temprature Control',
    'Equipemnt',
    'Chemicals',
    'Pest Control',
    'Sewage and Plumbing',
  ];
  double _progressValue = 0.0;
  DateTime? Date;
  bool isFieldShow = false;
  // bool isCalibratedShow = false;
  TextEditingController DateController = TextEditingController();
  selectDate(BuildContext context, int index) async {
    DateTime? selectDate;
    await DatePicker.showDatePicker(context,
        showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
          selectDate = date;
        }, currentTime: DateTime.now());
    if (selectDate != null) {
      setState(() {
        if (index == 0) {
          DateController.text = DateFormat('dd/MM/yyyy').format(selectDate!);
          Date = selectDate;
        }
      });
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Stack(
                  children:[ Container(
                    width: 414,
                    height: 204,
                    decoration:const BoxDecoration(color: kala),
                    child:const Padding(
                      padding:  EdgeInsets.only(top: 60,left: 10),
                      child: Text('Inspection Areas',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Dgreen),),
                    ),
                  ),
                    Positioned(child:
                    Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: Container(
                        width: double.infinity,
                        decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: gray,
                        ),
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 15),
                         child: Column(
                           children: [
                            const SizedBox(
                               height: 30,
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 3,right: 3),
                                 child: Container(
                                   width: 374,
                                   decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color:Colors.white60 ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       const Padding(
                                         padding:  EdgeInsets.only(left: 10,top: 10),
                                         child:  Text('Is the thermometer calibrated?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black,fontStyle: FontStyle.normal)),
                                       ),
                                       Row(
                                         children: [
                                           Theme(
                                             data: Theme.of(context).copyWith(
                                               unselectedWidgetColor: Colors.grey[500],
                                             ),
                                             child:Checkbox(
                                               checkColor: black,
                                               value: !isFieldShow ,
                                               activeColor: Dgreen,
                                               onChanged: (value) {
                                                 setState(() {
                                                   isFieldShow  = !isFieldShow ;
                                                 });
                                               },
                                               shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                             ),
                                           ),
                                           const Text('Yes',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Black),

                                           ),
                                           Theme(
                                             data: Theme.of(context).copyWith(
                                               unselectedWidgetColor: Colors.grey[500],
                                             ),
                                             child:Checkbox(
                                               checkColor: black,
                                               value: isFieldShow ,
                                               activeColor: Dgreen,
                                               onChanged: (value) {
                                                 setState(() {
                                                   isFieldShow  = !isFieldShow ;
                                                 });
                                               },
                                               shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                             ),
                                           ),
                                             Text('No',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: black)),
                                         ],
                                       ),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Visibility(
                                         visible: !isFieldShow ,
                                         child: GestureDetector(
                                           child: SizedBox(
                                             height: 40,
                                             child: TextFormField(
                                               textAlign: TextAlign.left,
                                               controller: DateController,
                                               decoration:const InputDecoration(
                                                 border: OutlineInputBorder(),
                                                 hintText: 'Select Date',
                                                 contentPadding: EdgeInsets.only(left: 10),
                                                 hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: GREY,),
                                                 suffixIcon: Padding(
                                                   padding: EdgeInsets.only(bottom:8),
                                                   child: Icon(Icons.calendar_month_outlined,size: 20),
                                                 ),
                                                 enabled: false,
                                               ),
                                             ),
                                           ),
                                           onTap: (){
                                             selectDate(context, 0);
                                           },
                                         ),
                                       ),
                                       Visibility(
                                           visible:isFieldShow ,
                                           child: const Text('Calibrate now!',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: green)))
                                     ],
                                   ),
                                 ),

                             ),
                            const SizedBox(
                               height: 10,
                             ),
                             Visibility(
                               visible: !isFieldShow ,
                               child: ListView.builder(
                                 physics: ScrollPhysics(),
                                   shrinkWrap: true,
                                   itemCount: areas.length,
                                   itemBuilder: (Context, index){
                                     return GestureDetector(
                                       onTap: (){
                                         if(index==0){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Documentation()));
                                         }
                                         else if(index==1){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Hygeine()));
                                         }
                                         else if(index==2){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Sources()));
                                         }
                                         else if(index==3){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Contamination()));
                                         }
                                         else if(index==4){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Sanitaiton()));
                                         }
                                         else if(index==5){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Temprature()));
                                         }
                                         else if(index==6){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Equipment()));
                                         }
                                         else if(index==7){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Chemical()));
                                         }
                                         else if(index==8){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Pest()));
                                         }
                                         else if(index==9){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const Sewage()));
                                         }
                                       },
                                       child:Container(
                                         child: Card(
                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                           elevation: 0,
                                           color: Colors.white,
                                           child: Column(children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(top: 20,left: 10),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                             Text(areas[index],style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Sblack)),
                                                const Icon(Icons.arrow_forward_ios_outlined,color: black,size: 15,),
                                                 ],),
                                               ),
                                          const SizedBox(height: 20,),
                                           LinearProgressIndicator(
                                                 backgroundColor: GREEN,
                                                 valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                                                 value: _progressValue,
                                               ),

                                             ],),
                                         ),
                                       ),
                                     );
                                   }),
                             ),

                           ],
                         ),
                         ),
                      ),
                          ),
                        ),
                    ]),
             const SizedBox(
                height: 40
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: InkWell(
                  child: Container(
                    width: 340,
                    height: 60,
                    decoration: BoxDecoration(borderRadius:const BorderRadius.all(Radius.circular(8)),color: isFieldShow?const Color.fromRGBO(142, 145, 140, 0.6): kala),
                    child:Center(child:  Text('Submit',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color:isFieldShow? white: Green ))),
                  ),
                  onTap: (){
                    isFieldShow?
                        Container()
                   : Navigator.push(context, MaterialPageRoute(builder: (context)=>Done()));
                  },
                ),
              ),
             const SizedBox(
                  height: 20
              ),
            ],
          ),
        ),

      ),
    );
  }


}