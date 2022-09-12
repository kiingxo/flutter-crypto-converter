import 'package:http/http.dart' as http;
import 'dart:convert';

import '../modelsandclasses/currencylist.dart';

const apikey = "11809FF4-584A-436A-B378-E73311040BB1";

class Apikeyconstant {}

class HttpClient {
  Future getcoinapidata(String selectedcurrency) async {
    //need  to create a logic to call different crypto data to the ui with this class

    Map<String, String> cryptoPrices = {};
    for (String cryptosymbol in Fiatandcryptolist().currenciesList) {
      //
      var url =
          "https://rest.coinapi.io/v1/exchangerate/$cryptosymbol/$selectedcurrency?apikey=";
      //api url
      var apiurl = url + apikey;
      //Get request to url
      http.Response response = await http.get(Uri.parse(apiurl));
      try {
        //check for sucess
        if (response.statusCode == 200) {
          //decode json
          var responseDecoded = jsonDecode(response.body);
          var cryptoprice = responseDecoded["rate"];
          cryptoPrices[cryptosymbol] = cryptoprice.toStringAsFixed(0);
        } else {
          //handle unsucessful request
          print("Error ${response.statusCode}");
          throw "request was unsucessful";
        }
      } catch (e) {
        //create a logic to catch the error if network returns anything=!200
        print(e);
      }
    }
    return cryptoPrices;
  }
}
