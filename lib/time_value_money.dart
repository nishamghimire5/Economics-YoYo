// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:engineering_economics/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:engineering_economics/formulas/simple_interest.dart';

import 'formulas/intrest_calculators.dart';

//default widget -if nothing returned
class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.amber,
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
    "2. Intrest Calculator",
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
                                  return InterestCalculator();
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
