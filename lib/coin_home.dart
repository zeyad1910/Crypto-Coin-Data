import 'dart:io';

import 'package:coin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinHome extends StatefulWidget {
  @override
  _CoinHomeState createState() => _CoinHomeState();
}

String selectedCurrency = 'USD';

class _CoinHomeState extends State<CoinHome> {
  DropdownButton<String> androidButton() {
    List<DropdownMenuItem<String>> dropDowMenuList = [];
    for (String coin in currenciesList) {
      Widget item = DropdownMenuItem(
        child: Text(coin),
        value: coin,
      );
      dropDowMenuList.add(item);
    }
    return DropdownButton<String>(
      items: dropDowMenuList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCoinData();
        });
      },
      value: selectedCurrency,
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> textList = [];
    for (String coin in currenciesList) {
      Text textWidget = Text(coin);
      textList.add(textWidget);
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedCurrency = currenciesList[index];
            getCoinData();
          });
        },
        children: textList);
  }

  bool isWaiting = false;
  Map<String, int> currenciesPrice = {};
  void getCoinData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      setState(() {
        currenciesPrice = data;
      });
      isWaiting = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Crypto Coins Price',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.lightBlue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '1 BTC = ${isWaiting ? '?' : currenciesPrice['BTC']} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.lightBlue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '1 ETH = ${isWaiting ? '?' : currenciesPrice['ETH']} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.lightBlue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '1 LTC = ${isWaiting ? '?' : currenciesPrice['LTC']} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              height: 150.0,
              padding: EdgeInsets.only(bottom: 30.0),
              alignment: Alignment.center,
              color: Colors.lightBlue,
              child: Platform.isIOS ? iosPicker() : androidButton(),
            ),
          ],
        ),
      ),
    );
  }
}
