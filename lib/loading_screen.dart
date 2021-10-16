import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  GetData rateData = GetData();

  void getExchangeRateData() async {
    print("getExchangeRateDataStart");
    List<dynamic> data = [];
    for (String item in cryptoList){
      data.add(await rateData.getRateData(crypto: item, currency: "AUD"));
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PriceScreen(data);
      }),
    );
    print("getExchangeRateDataEnd");
  }

  @override
  void initState() {
    getExchangeRateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          size: 75,
          color: Colors.black,
        ),
      ),
    );
    ;
  }
}
