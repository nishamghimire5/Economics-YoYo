// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:engineering_economics/formulas/f_when_p_given.dart';
import 'package:engineering_economics/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:engineering_economics/formulas/simple_interest.dart';

import 'formulas/f_when_a_given.dart';
import 'formulas/p_when_f_givven.dart';

//default widget -if nothing returned
class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Screen'),
      ),
      body: Center(
        child: Text('There is nothing to display :)'),
      ),
    );
  }
}

class TimeValueMoney extends StatefulWidget {
  const TimeValueMoney({Key? key}) : super(key: key);

  @override
  State<TimeValueMoney> createState() => _TimeValueMoneyState();
}

class _TimeValueMoneyState extends State<TimeValueMoney> {
  final List<String> _chapterTitles = [
    "1. Simple Interest",
    "2. Finding F when P given",
    "3. Finding P when F given",
    "4. Finding F when A given",
    "5. Finding A when F given",
    "6. Finding P when A given",
    "7. Finding A when P given",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Bitmap.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                margin: const EdgeInsets.only(top: 50, left: 20),
                child: Column(
                  children: _chapterTitles.map((title) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RoundedButton(
                        alignMent: Alignment.centerLeft,
                        text: title,
                        fontSize: 18,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                if (title == _chapterTitles[0]) {
                                  return SimpleIntrestCalculator();
                                } else if (title == _chapterTitles[1]) {
                                  return FWhenPGiven();
                                } else if (title == _chapterTitles[2]) {
                                  return PWhenFGiven();
                                } else if (title == _chapterTitles[3]) {
                                  return FWhenAGiven();
                                } else if (title == _chapterTitles[4]) {
                                  // return AWhenFGiven();
                                } else if (title == _chapterTitles[5]) {
                                  // return PWhenAGiven();
                                } else if (title == _chapterTitles[6]) {
                                  // return AWhenPGiven();
                                }

                                return DefaultWidget();
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
