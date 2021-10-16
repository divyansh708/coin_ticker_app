import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apiKey = "4B84B3EF-65BC-422A-89B4-85DE625D6268";
const String apiURL = "https://rest.coinapi.io/v1/exchangerate";

class GetData {
  Future<dynamic> getRateData(
      {required String crypto, required String currency}) async {
    print("getRateDataStart");
    var parsedURL = Uri.parse("$apiURL/$crypto/$currency?apikey=$apiKey");
    http.Response response = await http.get(parsedURL);
    if (response.statusCode == 200) {
      print("getRateDataEndWith200");
      return response.body;
    } else {
      print("getRateDataEndWithError");
      return response.statusCode;
    }
  }

  double getRate(dynamic rateData) {
    print("getRateStart");
    double rate;
    if(rateData is int){
      rate = 404;
    }else {
      rate = jsonDecode(rateData)['rate'];
    }
    print("getRateEnd");
    return rate;
  }
}
