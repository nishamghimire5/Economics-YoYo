// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleIntrestCalculator extends StatefulWidget {
  const SimpleIntrestCalculator({super.key});

  @override
  State<SimpleIntrestCalculator> createState() =>
      _SimpleIntrestCalculatorState();
}

var _formKey = GlobalKey<FormState>();

const List<String> _currencies = <String>['Rupees', 'Dollars', 'Pounds'];

class _SimpleIntrestCalculatorState extends State<SimpleIntrestCalculator> {
  final _minimumPadding = 5.0;
  String _dropdownValue = _currencies.first;

  var displayResult = '';

  final principalController = TextEditingController();
  final roiController = TextEditingController();
  final termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/Bitmap.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Container(
          // margin: EdgeInsets.all(_minimumPadding * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                  right: _minimumPadding * 5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: TextFormField(
                  controller: principalController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                    return null;
                  },
                  //for number only
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    labelText: 'Principle',
                    hintText: 'Enter Principle e.g. 50000',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: _minimumPadding * 5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rate';
                    }
                    return null;
                  },
                  controller: roiController,
                  //for number only
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    labelText: 'Rate',
                    hintText: 'In Percetange',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: _minimumPadding * 5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter time';
                          }
                          return null;
                        },
                        controller: termController,
                        //for number only
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          labelText: 'Time',
                          hintText: 'In Years',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: DropdownMenu<String>(
                          inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          initialSelection: _dropdownValue,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: _currencies
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: _minimumPadding * 5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 18.0),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.lightGreen,
                          elevation: 20, // Elevation
                          shadowColor: Colors.amber, // Shadow Color
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState?.validate() == true) {
                              displayResult = _calculateTotalReturns();
                            }
                          });
                        },
                        child: Text('Calculate'),
                      ),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 18.0),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.red,
                          elevation: 20, // Elevation
                          shadowColor: Colors.amber, // Shadow Color
                        ),
                        onPressed: () {
                          _reset();
                        },
                        child: Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: _minimumPadding * 5,
                        top: _minimumPadding * 3,
                      ),
                      child: Text(
                        'Results:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '''
                        Simple Interest [I] = P × r × t
                        Amount [A] = P ( 1 + rt )
                        ''',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[900]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: _minimumPadding * 5,
                        left: _minimumPadding * 3,
                        top: _minimumPadding * 3,
                      ),
                      child: Text(
                        displayResult,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      margin: EdgeInsets.all(_minimumPadding * 10),
      child: image,
    );
  }

  String _calculateTotalReturns() {
    var sign = '';
    double principle = double.parse(principalController.text);
    double roi = (double.parse(roiController.text)) / 100;
    double term = double.parse(termController.text);
    switch (_dropdownValue) {
      case 'Rupees':
        sign = 'Rs.';
        break;
      case 'Dollars':
        sign = '\$';
        break;
      case 'Pounds':
        sign = '£';
        break;
    }

    double totalAmount = principle * (1 + term * roi);
    double totalInterest = (principle * roi * term);

    String result = '''
        End Balance:  	$sign $totalAmount
        Total Interest:  	$sign $totalInterest

        Calculation steps:
        Total Interest =	$sign $principle × $roi% × $term
        =	$sign $totalInterest

        End Balance =	$sign $principle + $totalInterest
        =	$sign $totalAmount
        ''';
    return result;
  }

  void _reset() {
    principalController.clear();
    roiController.clear();
    termController.clear();
    setState(() {
      _dropdownValue = _currencies.first;
      displayResult = '';
      //no ideas how to implement the error msg reset and textfields reset simultaneusly
      // _formKey.currentState!.reset();
    });
  }
}
