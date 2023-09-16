// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:engineering_economics/formulas/calculation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InterestCalculator extends StatefulWidget {
  const InterestCalculator({super.key});

  @override
  State<InterestCalculator> createState() => _InterestCalculatorState();
}

var _formKey = GlobalKey<FormState>();

const List<String> _currencies = <String>['Rupees', 'Dollars', 'Pounds'];
const List<String> _compounded = <String>[
  'Annually',
  'Semi',
  'Quarterly',
  'Monthly',
  'Weekly',
  'Daily'
];
const List<String> _givenValue = <String>['Annuity', 'Present', 'Future'];

class _InterestCalculatorState extends State<InterestCalculator> {
  // bool _showDataTable = false
  final _minimumPadding = 5.0;

  String _dropdownValue = _currencies.first;
  String _compoundedValue = _compounded.first;
  String _choosenGiven = _givenValue.first;

  var displayResult = '';

  final amountController = TextEditingController();
  final roiController = TextEditingController();
  final termController = TextEditingController();
  final currencyController = TextEditingController();
  final compoundedController = TextEditingController();
  final givenController = TextEditingController();
  // final nController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interest Calculator"),
        backgroundColor: Colors.amber,
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
                  right: _minimumPadding * 10.5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      //text field for amount value
                      flex: 2,
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Amount';
                          }
                          return null;
                        },
                        controller: amountController,
                        //for number only
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
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
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          labelText: 'Amount',
                          hintText: 'in $_choosenGiven',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      //dropdown for annuity,present,or future what's given
                      child: Container(
                        padding: EdgeInsets.only(right: 25),
                        child: DropdownMenu<String>(
                          controller: givenController,
                          inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          initialSelection: _choosenGiven,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _choosenGiven = value!;
                            });
                          },
                          dropdownMenuEntries: _givenValue
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
                  right: _minimumPadding * 10.5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      //text field for rate %
                      flex: 2,
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter rate';
                          }
                          return null;
                        },
                        controller: roiController,
                        //for number only
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
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
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          labelText: 'Rate',
                          hintText: 'In Percetange',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      //dropdown for compounded time
                      child: Container(
                        padding: EdgeInsets.only(right: 35),
                        child: DropdownMenu<String>(
                          controller: compoundedController,
                          inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          initialSelection: _compoundedValue,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _compoundedValue = value!;
                            });
                          },
                          dropdownMenuEntries: _compounded
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
                  right: _minimumPadding * 10.5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      //text field for time field
                      flex: 2,
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter time to invest';
                          }
                          return null;
                        },
                        controller: termController,
                        //for number only
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
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
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          labelText: 'Time',
                          hintText: 'In Years',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      //dropdown for currency values
                      child: Container(
                        padding: EdgeInsets.only(right: 25),
                        child: DropdownMenu<String>(
                          controller: currencyController,
                          inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
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
                  right: _minimumPadding * 4,
                  left: _minimumPadding * 4,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  //for calculate and for reset in row
                  children: <Widget>[
                    Expanded(
                      //calculate Button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 21.0),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.lightGreen,
                          elevation: 20, // Elevation
                          shadowColor: Colors.amber, // Shadow Color
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => Calculation(
                                    amount: double.parse(amountController.text),
                                    roi: double.parse(roiController.text),
                                    term: double.parse(termController.text),
                                    sign: currencyController.text,
                                    given: givenController.text,
                                    // compounded: compoundedController,
                                  ))));
                          setState(() {
                            if (_formKey.currentState?.validate() == true) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // displayResult = _calculateTotalReturns();
                              // _showDataTable = true;
                            }
                          });
                        },
                        child: Text('Calculate'),
                      ),
                    ),
                    SizedBox(
                      width: 7.5,
                    ),
                    Expanded(
                      //reset Button
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 21.0),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(70.0)),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.red,
                          elevation: 20, // Elevation
                          shadowColor: Colors.amber, // Shadow Color
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _reset();
                        },
                        child: Text('Reset'),
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

  void _reset() {
    amountController.clear();
    roiController.clear();
    termController.clear();
    setState(() {
      _dropdownValue = _currencies.first;
      _choosenGiven = _givenValue.first;
      _compoundedValue = _compounded.first;
    });
  }
}
