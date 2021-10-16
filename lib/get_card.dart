import 'package:flutter/material.dart';

class GetCard extends StatefulWidget {

  GetCard({required this.cryptoUnit, required this.currencyUnit, required this.exchangeRate});
  String currencyUnit;
  double exchangeRate;
  String cryptoUnit;

  @override
  _GetCardState createState() => _GetCardState();
}

class _GetCardState extends State<GetCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.cryptoUnit} = ${widget.exchangeRate.toInt()} ${widget.currencyUnit}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
