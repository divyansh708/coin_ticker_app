import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'get_card.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen(this.rateData);
  late List<dynamic> rateData;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  GetData coinData = GetData();

  String selectedCurrency = "AUD";
  int selectedIndex = 0;
  List<double> rate = [];

  void updateRate(List<dynamic> exchangeData) {
    print("updateRateStart");
    rate.clear();
    setState(() {
      for (dynamic data in exchangeData) {
        rate.add(coinData.getRate(data));
      }
    });
    print("updateRateEnd");
  }

  @override
  void initState() {
    updateRate(widget.rateData);
    super.initState();
  }

  CupertinoPicker getiOSPicker() {
    List<Text> pickerList = [];
    for (String item in currenciesList) {
      pickerList.add(Text(item));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (index)  {
        setState(() async{
          selectedIndex = index;
          selectedCurrency = currenciesList[selectedIndex];
          List<dynamic> exchangeData = [];
          for (String item in cryptoList) {
            exchangeData.add(await coinData.getRateData(
                crypto: item, currency: selectedCurrency));
        }
          updateRate(exchangeData);
        });
      },
      children: pickerList,
    );
  }

  DropdownButton getAndroidPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(item),
          value: item,
        ),
      );
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() async{
          selectedCurrency = value;
          List<dynamic> exchangeData = [];
          for (String item in cryptoList) {
            exchangeData.add(await coinData.getRateData(
                crypto: item, currency: selectedCurrency));
        }
          updateRate(exchangeData);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GetCard(
                  cryptoUnit: "BTC",
                  currencyUnit: selectedCurrency,
                  exchangeRate: rate[0],
                ),
                GetCard(
                  cryptoUnit: "ETH",
                  currencyUnit: selectedCurrency,
                  exchangeRate: rate[1],
                ),
                GetCard(
                  cryptoUnit: "LTC",
                  currencyUnit: selectedCurrency,
                  exchangeRate: rate[2],
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getiOSPicker(),
          ),
        ],
      ),
    );
  }
}
