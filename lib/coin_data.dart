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
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '0EC0E2FA-E4E4-4CA4-A662-9270513329D1';

class CoinData {
  Future<Map> getCoinData(String selectedCurrency) async {
    Map<String, int> currenciesPrice = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(
          Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey'));
      if (response.statusCode == 200) {
        var fullCoinData = response.body;
        double rate = jsonDecode(fullCoinData)['rate'];
        currenciesPrice[crypto] = rate.toInt();
      } else {
        throw 'there is a problem with the api';
      }
    }
    return currenciesPrice;
  }
}
