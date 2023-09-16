// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AWhenPGiven extends StatefulWidget {
  const AWhenPGiven({super.key});

  @override
  State<AWhenPGiven> createState() => _AWhenPGivenState();
}

var _formKey = GlobalKey<FormState>();

const List<String> _currencies = <String>['Rupees', 'Dollars', 'Pounds'];

class _AWhenPGivenState extends State<AWhenPGiven> {
  bool _showDataTable = false;
  final _minimumPadding = 5.0;
  String _dropdownValue = _currencies.first;

  var displayResult = '';

  final principleController = TextEditingController();
  final roiController = TextEditingController();
  final termController = TextEditingController();
  // final nController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finding A when P is given"),
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
                  right: _minimumPadding * 5,
                  left: _minimumPadding * 3,
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: TextFormField(
                  controller: principleController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Principle amount';
                    }
                    return null;
                  },
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
                        width: 3,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    labelText: 'Principle Amount',
                    hintText: 'Enter Principle Amount e.g. 50000',
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              displayResult = _calculateTotalReturns();
                              _showDataTable = true;
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
                          FocusManager.instance.primaryFocus?.unfocus();
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
                        top: _minimumPadding * 6,
                        bottom: _minimumPadding * 3,
                      ),
                      child: Text(
                        'Formula:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'A = P [ { i (1+i)^N } / { ( 1 + i )^N - 1 } ]',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: _minimumPadding * 5,
                        left: _minimumPadding * 3,
                        top: _minimumPadding * 3,
                      ),
                      child: Center(
                        child: Text(
                          displayResult,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: _minimumPadding * 5,
                        bottom: _minimumPadding * 5,
                        top: _minimumPadding * 1,
                      ),
                      child: Visibility(
                        visible: _showDataTable,
                        child: Text(
                          'Schedule:',
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Visibility(
                        visible: _showDataTable,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DataTable(
                            // dataRowMinHeight: 0, // Set dataRowHeight to 0
                            dividerThickness: 3.0, // Set dividerThickness to 0
                            columnSpacing: 60,
                            columns: [
                              DataColumn(
                                label: const Text(
                                  'Year',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: const Text(
                                  'Intrest',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: const Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ],
                            rows: _buildTableRows(),
                          ),
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

  List<DataRow> _buildTableRows() {
    double principle = double.tryParse(principleController.text) ?? 0.0;
    double roi = double.tryParse(roiController.text) ?? 0.0;
    double term = double.tryParse(termController.text) ?? 0.0;
    // double n = double.tryParse(termController.text) ?? 1.0;

    var sign = '';
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

    double annuity = principle *
        ((roi / 100) * pow(1 + (roi / 100), term)) /
        (pow(1 + (roi / 100), term) - 1);

    List<DataRow> rows = [];

    double increasingAmount = 0;
    double interestValue = 0;

    for (int i = 0; i <= term; i++) {
      increasingAmount += annuity;
      if (i == 0) {
        interestValue = 0;
      }
      if (i == 1) {
        increasingAmount = annuity;
        // interestValue = increasingAmount * (roi / 100);
      }
      if (i != 0 && i != term) {
        interestValue = increasingAmount * (roi / 100);
        increasingAmount += interestValue;
      }
      rows.add(
        DataRow(
          cells: [
            DataCell(
              Text(
                i.toString(),
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            DataCell(
              Text(
                '$sign ${interestValue.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            DataCell(
              Text(
                '$sign ${increasingAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return rows;
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
    double principle = double.parse(principleController.text);
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

    double annuityAmount =
        principle * (roi * pow(1 + roi, term)) / (pow(1 + roi, term) - 1);
    // double totalInterest = -annuityAmount + principle;

    // Total Interest:  	$sign ${totalInterest.toStringAsFixed(2)}
    String result = '''
        Annuity Required:  	$sign ${annuityAmount.toStringAsFixed(2)}

        Calculation steps:

        Annuity Amount = 
        = $sign $principle x 
        [{(1 + $roi)^$term x $roi} / {(1 + $roi)^$term - 1}]

        =	$sign ${annuityAmount.toStringAsFixed(2)}
        ''';
    return result;
  }

  void _reset() {
    principleController.clear();
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
