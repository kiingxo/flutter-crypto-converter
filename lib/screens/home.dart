import 'package:bitcointracker/modelsandclasses/currencylist.dart';
import 'package:bitcointracker/service/apicall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCurrency = 'USD';
  String coinprice = 'loading ';

//logic to get currency list from seperate file
  List<Widget> getCurrency() {
    List<Widget> currencyitems = <Widget>[];
    for (int i = 0; i < Fiatandcryptolist().currenciesList.length; i++) {
      String currency = Fiatandcryptolist().currenciesList[i];
      print(currency);
      currencyitems.add(
        Text(
          currency,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return currencyitems;
  }

  getdecodeddata() async {
    try {
      double decodeddata = await HttpClient().getcoinapidata(selectedCurrency);
      setState(() {
        coinprice = decodeddata.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getdecodeddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrency();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: null,
              child: const Text(
                "CryptoConvert",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.purple,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          '1 BTC = $coinprice $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CryptoFrame(
                    cryptoprice: coinprice,
                    selectedCurrency: selectedCurrency,
                    cryptoCurrency: "ETH"),
              ],
            ),
            Container(
              height: 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30),
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (int selectedindex) {
                  setState(() {
                    selectedCurrency =
                        Fiatandcryptolist().currenciesList[selectedindex];
                    getdecodeddata();
                  });
                },
                children: getCurrency(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CryptoFrame extends StatelessWidget {
  const CryptoFrame({
    required this.cryptoprice,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String cryptoprice;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.purple,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 100,
          child: Center(
            child: Text(
              '1 $cryptoCurrency= $cryptoprice $selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// class Homepagebody extends StatefulWidget {
//   const Homepagebody({Key? key}) : super(key: key);

//   @override
//   State<Homepagebody> createState() => _HomepagebodyState();
// }

// class _HomepagebodyState extends State<Homepagebody> {
//   int index = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // ListView.builder(
//         //   itemBuilder: ((context, index) {
//         //     return Container();
//         //   }),
//         // ),
//       ],
//     );
//   }
// }
