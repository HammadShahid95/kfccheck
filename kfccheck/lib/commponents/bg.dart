import 'package:flutter/material.dart';

import '../res/const.dart';

class Background extends StatelessWidget {
  final String title;
  final Widget child;

  const Background({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: gray,
          body: Stack(children: [
            Container(
              width: 424,
              height: 204,
              decoration: const BoxDecoration(color: black),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 80),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(Icons.arrow_back_ios, color: white),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Dgreen),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: child,
            ),
          ])),
    );
  }
}
