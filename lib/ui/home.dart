import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  _Quote _quote = new _Quote("", "");
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/img-bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                child: isShow
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(80),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Text(
                                  _quote.text,
                                  style: new TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  '"${_quote.author}"',
                                  style: new TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                      )
                    : null,
              ),
              TextButton.icon(
                  onPressed: _showQuote,
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.blueAccent.shade700.withAlpha(200)),
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Icon(
                      Icons.emoji_objects_outlined,
                      color: Colors.white,
                    ),
                  ),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: Text(
                      "Inspire me",
                      style: new TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showQuote() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/quotes.json");
    Iterable iterable = json.decode(data);
    List<_Quote> _quotes =
        List<_Quote>.from(iterable.map((model) => _Quote.fromJson(model)));

    Random rnd = new Random();
    int i = rnd.nextInt(_quotes.length);

    setState(() {
      isShow = true;
      _quote = _quotes[i];
    });
  }
}

class _Quote {
  String text;
  String author;

  _Quote(this.text, this.author);

  static _Quote fromJson(json) {
    return new _Quote(json['text'], json['author']);
  }
}
