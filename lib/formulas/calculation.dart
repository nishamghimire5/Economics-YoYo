// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class Calculation extends StatefulWidget {
  final double amount;
  final double roi;
  final double term;
  final String given;
  final String sign;

  const Calculation({
    Key? key,
    required this.amount,
    required this.roi,
    required this.term,
    required this.sign,
    required this.given,
  }) : super(key: key);

  @override
  State<Calculation> createState() => _CalculationState();
}

var _formKey = GlobalKey<FormState>();

class _CalculationState extends State<Calculation> {
  final _minimumPadding = 5.0;
  String displayResult = '';

  @override
  void initState() {
    super.initState();
    calculateResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solution"),
        backgroundColor: Colors.amber,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          // margin: EdgeInsets.all(_minimumPadding * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            children: <Widget>[
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
                        //formula text written
                        'Formula:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      //display formula
                      child: Text(
                        displayResult,
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
                        //display calculations
                        child: Text(
                          _calculateTotalReturns(),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: _minimumPadding * 5,
                        bottom: _minimumPadding * 1,
                        top: _minimumPadding * 1,
                      ),
                      child: Text(
                        //Schedule
                        'Schedule',
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: _minimumPadding * 5,
                        bottom: _minimumPadding * 3,
                        top: _minimumPadding * 1,
                      ),
                      child: Text(
                        //from annuity {text}
                        'From Annuity:',
                        style: TextStyle(
                          color: Colors.pink[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DataTable(
                          //data table for annuity
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: _minimumPadding * 5,
                        bottom: _minimumPadding * 3,
                        top: _minimumPadding * 5,
                      ),
                      child: Text(
                        //initial investment {text}
                        'From initial investment:',
                        style: TextStyle(
                          color: Colors.pink[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DataTable(
                          //data table 2 for initial investment
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
                          rows: _buildTableRows2(),
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

//from annuity---------------------------------------------------------------------------------
  List<DataRow> _buildTableRows() {
    double annuity = widget.amount;
    var sign = '';
    switch (widget.sign) {
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

    if (widget.given == 'Present') {
      annuity = widget.amount *
          ((widget.roi / 100) * pow(1 + (widget.roi / 100), widget.term)) /
          (pow(1 + (widget.roi / 100), widget.term) - 1);
    } else if (widget.given == 'Future') {
      annuity = widget.amount *
          ((widget.roi / 100) / (pow(1 + (widget.roi / 100), widget.term) - 1));
    }

    List<DataRow> rows = [];

    double increasingAmount = 0;
    double interestValue = 0;
    double profitPercentage = 0;
    double totalInterest = 0;

    for (int i = 0; i <= widget.term + 1; i++) {
      increasingAmount += annuity;
      if (i == 0) {
        interestValue = 0;
      }
      if (i == 1) {
        increasingAmount = annuity;
      }
      if (i != 0 && i <= widget.term) {
        interestValue = increasingAmount * (widget.roi / 100);
        if (i != widget.term) {
          increasingAmount += interestValue;
        }
      }
      if (i >= 1 && i < widget.term) {
        totalInterest += interestValue;
      }
      if (i == widget.term) {
        profitPercentage = ((increasingAmount - (widget.term * annuity)) /
                (widget.term * annuity)) *
            100; // Calculate profit percentage
      }
      if (i == (widget.term + 1)) {
        // Add last row to display total interest
        rows.add(
          DataRow(
            cells: [
              DataCell(
                Text(
                  'Total Interest',
                  style: TextStyle(
                    color: Colors.red[800],
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '$sign ${totalInterest.toStringAsFixed(2)}', // Display total interest
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${profitPercentage.toStringAsFixed(2)}%', // Calculate and display profit percentage
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
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
                  i == widget.term
                      ? '-'
                      : '$sign ${interestValue.toStringAsFixed(2)}',
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
    }
    return rows;
  }

  ///------------------------------------------------------------------------------------------

//from initial investment-----------------------------------------------------------------------
  List<DataRow> _buildTableRows2() {
    double previousAmount = widget.amount, present = widget.amount;
    var sign = '';
    switch (widget.sign) {
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

    if (widget.given == 'Future') {
      previousAmount =
          present = widget.amount * pow((1 + widget.roi / 100), (-widget.term));
    } else if (widget.given == 'Annuity') {
      previousAmount = present = widget.amount *
          ((pow(1 + (widget.roi / 100), widget.term) - 1) /
              ((widget.roi / 100) * pow(1 + (widget.roi / 100), widget.term)));
    }

    List<DataRow> rows = [];

    double profitPercentage = 0;
    double totalInterest = 0;

    for (int i = 0; i <= widget.term + 1; i++) {
      double amount = present * pow((1 + (widget.roi / 100)), i);
      double interestValue = amount - previousAmount;

      if (i <= widget.term) {
        totalInterest += interestValue;
      }

      if (i == widget.term) {
        profitPercentage =
            ((totalInterest) / present) * 100; // Calculate profit percentage
      }

      if (i == (widget.term + 1)) {
        // Add last row to display total interest
        rows.add(
          DataRow(
            cells: [
              DataCell(
                Text(
                  'Total Interest',
                  style: TextStyle(
                    color: Colors.red[800],
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '$sign ${totalInterest.toStringAsFixed(2)}', // Display total interest
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${profitPercentage.toStringAsFixed(2)}%', // Calculate and display profit percentage
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
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
                  '$sign ${amount.toStringAsFixed(2)}',
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
      previousAmount = amount;
    }
    return rows;
  }

  String _calculateTotalReturns() {
    //calculate annuity
    double amount_ = widget.amount;
    double term_ = widget.term;
    double roi_ = widget.roi / 100;

    var sign = '';
    switch (widget.sign) {
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

    // double totalInterest = -annuityAmount + amount;

    // Total Interest:  	$sign ${_termInterest.toStringAsFixed(2)}
    switch (widget.given) {
      case 'Present':
        double annuityAmount = amount_ *
            (roi_ * pow(1 + roi_, term_)) /
            (pow(1 + roi_, term_) - 1);
        double futureAmount = amount_ * pow((1 + (roi_)), term_);
        return '''

        Annuity Required:  	$sign ${annuityAmount.toStringAsFixed(2)}
        End Future Balance:  	$sign ${futureAmount.toStringAsFixed(2)}
      
        Calculation steps:

        Annuity Amount = 
        = $sign $amount_ x 
        [{(1 + $roi_)^$term_ x $roi_} / {(1 + $roi_)^$term_ - 1}]
        =	$sign ${annuityAmount.toStringAsFixed(2)}

        Future Amount =	$sign $amount_ x (1 + $roi_)^$term_
        =	$sign ${futureAmount.toStringAsFixed(2)}

        ''';
      case 'Future':
        double presentAmount = amount_ * pow((1 + roi_), (-term_));
        double annuityAmount = amount_ * (roi_ / (pow(1 + roi_, term_) - 1));
        return '''
        Present Sum Required:  	$sign ${presentAmount.toStringAsFixed(2)}
        Annuity Required:  	$sign ${annuityAmount.toStringAsFixed(2)}
        
        Calculation steps:

        Present Amount =	$sign $amount_ x (1 + $roi_)^-$term_
        =	$sign ${presentAmount.toStringAsFixed(2)}

        Annuity Amount = 
        = $sign $amount_ x [ $roi_ / {(1 + $roi_)^$term_ - 1} ]
        = $sign ${annuityAmount.toStringAsFixed(2)}
        ''';
      case 'Annuity':
        double presentAmount = amount_ *
            ((pow(1 + roi_, term_) - 1) / (roi_ * pow(1 + roi_, term_)));
        double futureAmount = amount_ * ((pow(1 + roi_, term_) - 1) / roi_);

        return '''
        Present Sum Required:  	$sign ${presentAmount.toStringAsFixed(2)}
        End Future Balance:  	$sign ${futureAmount.toStringAsFixed(2)}

        Calculation steps:

        Present Amount = 
        = $sign $amount_ x 
        [{(1 + $roi_)^$term_ - 1} / {$roi_ x (1 + $roi_)^$term_}]
        =	$sign ${presentAmount.toStringAsFixed(2)}

        Future Balance = 
        = $sign $amount_ x [{(1 + $roi_)^$term_ - 1} / $roi_]
        = $sign ${futureAmount.toStringAsFixed(2)}
        ''';
    }
    return '';
  }

  String aWhenPformula() {
    return 'A = P [ { i (1+i)^N } / { ( 1 + i )^N - 1 } ]';
  }

  String fWhenPformula() {
    return 'F = P(1 + i)^N';
  }

  String pWhenAformula() {
    return 'P = A [ { (1+i)^N - 1 } / { i( 1 + i )^N } ]';
  }

  String fWhenAformula() {
    return 'F = A [ { ( 1 + i )^N - 1 } / i ]';
  }

  String pWhenFformula() {
    return 'P = F(1 + i)^-N';
  }

  String aWhenFformula() {
    return 'A = F [ i / { ( 1 + i )^N - 1 } ]';
  }

  void calculateResult() {
    switch (widget.given) {
      case 'Present':
        displayResult = '${fWhenPformula()}\n\n${aWhenPformula()}';
        break;
      case 'Future':
        displayResult = '${pWhenFformula()}\n\n${aWhenFformula()}';
        break;
      case 'Annuity':
        displayResult = '${pWhenAformula()}\n\n${fWhenAformula()}';
        break;
    }
  }
}
