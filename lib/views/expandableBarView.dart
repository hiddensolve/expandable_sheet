import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpandableBarView extends StatefulWidget {
  const ExpandableBarView({super.key});

  @override
  State<ExpandableBarView> createState() => _ExpandableBarViewState();
}

class _ExpandableBarViewState extends State<ExpandableBarView> {
  int index = 0;

  List<Color> colorsList = [
    const Color.fromARGB(255, 4, 112, 194),
    const Color.fromARGB(255, 4, 15, 62),
    const Color.fromARGB(255, 19, 26, 96)
  ];

  int colorIndex = 0;
  bool dark = true;
  Color backGroundColor = const Color.fromARGB(255, 35, 35, 35);
  Color foreGroundColor = Colors.white;

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      colorIndex += 1;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        return AnimatedContainer(
          duration: const Duration(seconds: 3),
          onEnd: () {
            setState(() {
              colorIndex += 1;
            });
          },
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            colorsList[colorIndex % colorsList.length],
            colorsList[(colorIndex + 1) % colorsList.length],
            colorsList[(colorIndex + 2) % colorsList.length],
          ], tileMode: TileMode.decal)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const Expanded(child: SizedBox()),
                AnimatedContainer(
                  height: index == 0
                      ? height * 0.2
                      : index == 1
                          ? height * 0.5
                          : height * 0.8,
                  width: width,
                  duration: const Duration(seconds: 1),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: foreGroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      expandButton(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: backGroundColor,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "HiddenSolve",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: foreGroundColor),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  dark = !dark;
                                  backGroundColor = dark
                                      ? Colors.white
                                      : const Color.fromARGB(255, 35, 35, 35);
                                  foreGroundColor = !dark
                                      ? Colors.white
                                      : const Color.fromARGB(255, 35, 35, 35);
                                });
                              },
                              icon: Icon(
                                dark ? Icons.sunny : Icons.dark_mode,
                                color: backGroundColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: 100,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: backGroundColor,
                              margin: const EdgeInsets.all(0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ExpansionTile(
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  title: Text(
                                    "What is Rasomware",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: foreGroundColor,
                                    ),
                                  ),
                                  children: [
                                    Text(
                                      "Ransomware is a type of malicious software that is designed to block access to a computer system or its data until a sum of money, or ransom, is paid. It works by encrypting files on the victim's computer, making them inaccessible, and then demanding payment in exchange for a decryption key to unlock the files. The attackers typically demand payment in cryptocurrency to remain anonymous and untraceable.",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: foreGroundColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector expandButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          index == 0
              ? index = 1
              : index == 1
                  ? index = 2
                  : index = 0;
        });
      },
      child: Container(
        height: 13,
        width: 80,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: FittedBox(
            child: Icon(
          index < 2
              ? Icons.keyboard_arrow_up_outlined
              : Icons.keyboard_arrow_down_rounded,
          color: Colors.white,
        )),
      ),
    );
  }
}
