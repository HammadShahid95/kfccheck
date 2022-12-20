import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:kfccheck/res/const.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PaymentMethod> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 414,
                        height: 206,
                        decoration: const BoxDecoration(color: kala),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 60, left: 10),
                          child: Text(
                            'Payment',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Dgreen),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 629,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              color: gray,
                            ),
                            child: Form(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(19),
                                      ],
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(), hintText: "Card number", prefixIcon: Icon(Icons.credit_card)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Full Name",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Expiry Time",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "CVV",
                                      ),
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
                                            child: Text(
                                          'Save information for your future payments',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: lGrey),
                                        )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 160,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: black),
                                        child: Center(
                                            child:
                                                Text('Proceed Payment', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: yellow))),
                                      ),
                                      onTap: (() {
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
