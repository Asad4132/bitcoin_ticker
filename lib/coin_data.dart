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

class CoinData {
  var url = 'https://rest.coinapi.io/v1/exchangerate';
  var apiKey = '33644F54-A7D5-4F5D-8F29-DA2579F09EB7';
  getCoinData(String selectedCurrency, String crypto) async {
    var requestURL = '$url/$crypto/$selectedCurrency?apikey=$apiKey';
    var response = await http.get(requestURL);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rate'];
    } else {
      print('Response Error Code: ');
      print(response.statusCode);
      throw 'unable to get api data';
    }
  }
}
