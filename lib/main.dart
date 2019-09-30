import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:search_widget/search_widget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Api Search App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text("Api Search App");
  String query = "";
  int queryCount = 0;
  int queryLimit = 0;
  List itemList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if(this.customIcon.icon == Icons.search) {
                  this.customIcon = Icon(Icons.close);
                  this.customSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Something..."

                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    onSubmitted: (String str) {
                      setState(() {
                        query = str;
                      });
                      fetchList(query);
                    },
                  );
                }else{
                  this.customIcon = Icon(Icons.search);
                  this.customSearchBar = Text("Api Search App");
                }
              });
            },
            icon: customIcon,
          ),
        ],
        elevation: 10,
      ),
      body: _listView(context),
    );
  }

  Widget _listView(BuildContext context){

    return ListView.builder(
      itemCount: queryCount,
      itemBuilder: (context, index) {
        EbayItem item = EbayItem.fromJson(itemList[index]);
        Price price = Price.fromJson(item.price);
        return ListTile(
          title: Text(item.itemTitle.toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemDetailsPage(item: item, price: price,)),
            );
          },
        );
      },
    );
  }

  Future<void> fetchList(String str) async {
    String searchUrl = "https://api.sandbox.ebay.com/buy/browse/v1/item_summary/search?q=$str&limit=200";
    String myToken = "OAuthToken Goes Here";
    final response =
    await http.get(
      searchUrl,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + myToken,
        "X-EBAY-C-MARKETPLACE-ID": "EBAY_US",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    print(response.body);

    final responseJson = json.decode(response.body);

    final convertedResponse = EbayResponse.fromJson(responseJson);

    setState(() {
      queryCount = convertedResponse.total;
      queryLimit = convertedResponse.limit;
      itemList = convertedResponse.eList;
    });
  }
}

class EbayResponse {
  final int total;
  final int limit;
  final List<Object> eList;

  EbayResponse({this.total, this.limit, this.eList});

  factory EbayResponse.fromJson(Map<String, dynamic> json) {
    return EbayResponse(
      total: json['total'],
      limit: json['limit'],
      eList: json['itemSummaries'],
    );
  }
}

class EbayItem {
  final String itemId;
  final String itemTitle;
  final Object price;

  EbayItem({this.itemId, this.itemTitle, this.price});

  factory EbayItem.fromJson(Map<String, dynamic> json) {
    return EbayItem(
      itemId: json['itemId'],
      itemTitle: json['title'],
      price: json['price'],
    );
  }
}

class Price {
  final String value;
  final String currency;

  Price({this.value, this.currency});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      value: json['value'],
      currency: json['currency']
    );
  }
}

class ItemDetailsPage extends StatelessWidget {

  final EbayItem item;
  final Price price;

  ItemDetailsPage({Key key, @required this.item, @required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20.0), child: Text(item.itemTitle),),
          Padding(padding: EdgeInsets.all(20.0),child: Center(
            child: Row(
              children: <Widget>[
                Center(child: Text(price.value)),
                Center(child: Text(price.currency))
              ],
            ),
          ),),

        ],
      ),
    ),
    );
  }
}
