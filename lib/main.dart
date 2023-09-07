// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:engineering_economics/time_value_money.dart';
import 'package:flutter/material.dart';
import 'package:engineering_economics/widgets/rounded_button.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug false
      title: 'Economics App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, //white
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: Colors.amber,
            ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Bitmap.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headlineMedium,
                children: [
                  TextSpan(
                    text: 'Economics ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900],
                    ),
                  ),
                  TextSpan(
                    text: 'yoyo.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              child: RoundedButton(
                  alignMent: Alignment.center,
                  text: "Chapter 1: Time Value of Money",
                  fontSize: 20,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TimeValueMoney();
                        },
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 360),
            Column(
              children: [
                Text(
                  'Developed By',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 2,
                  width: 60,
                  color: Colors.pink[900],
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'TheNisham',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink[900],
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
