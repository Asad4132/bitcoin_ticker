import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList)
      dropDownItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getAPIData();
        });
      },
    );
  }

//  List<DropdownMenuItem> getDropDownItems() {
//    List<DropdownMenuItem<String>> dropDownItems = [];
//    for (String currency in currenciesList)
//      dropDownItems.add(DropdownMenuItem(
//        child: Text(currency),
//        value: currency,
//      ));
//    return dropDownItems;
//  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) pickerItems.add(Text(currency));
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getAPIData();
      },
      children: pickerItems,
    );
  }
//
//  List<Text> getPickerItems() {
//    List<Text> pickerItems = [];
//    for (String currency in currenciesList) pickerItems.add(Text(currency));
//    return pickerItems;
//  }

//  Widget getPickerOrDropDown() {
//    if (Platform.isIOS) {
//      return getCupertinoPicker();
//    } else {
//      return getDropDownButton();
//    }
//  }

  String bitCoinValue = '?';
  String eTHValue = '?';
  String lTCValue = '?';

  getAPIData() async {
    try {
      double valueForBTH =
          await CoinData().getCoinData(selectedCurrency, cryptoList[0]);
      double valueForETH =
          await CoinData().getCoinData(selectedCurrency, cryptoList[0]);
      double valueForLTC =
          await CoinData().getCoinData(selectedCurrency, cryptoList[0]);
      setState(() {
        bitCoinValue = valueForBTH.toInt().toString();
        eTHValue = valueForETH.toInt().toString();
        lTCValue = valueForLTC.toInt().toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getAPIData();
  }

  getMoreCryptos(String crypto, String bitCoinValue) {
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
            '1 $crypto = $bitCoinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

//      Padding(
//      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//      child: Card(
//        color: Colors.lightBlueAccent,
//        elevation: 5.0,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(10.0),
//        ),
//        child: Padding(
//          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//          child: Text(
//            '1 $crypto = $bitCoinValue $selectedCurrency',
//            textAlign: TextAlign.center,
//            style: TextStyle(
//              fontSize: 20.0,
//              color: Colors.white,
//            ),
//          ),
//        ),
//      ),
//    );
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              getMoreCryptos(cryptoList[0], bitCoinValue),
              getMoreCryptos(cryptoList[1], eTHValue),
              getMoreCryptos(cryptoList[2], lTCValue),
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:
                  Platform.isIOS ? getCupertinoPicker() : getDropDownButton()),
        ],
      ),
    );
  }
}

//DropdownButton<String>(
//value: selectedCurrency,
//items: getDropDownItems(),
//onChanged: (value) {
//setState(() {
//selectedCurrency = value;
//});
//},
//),
