import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:ocr/newFile.dart';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  List _text = [];
  var data;
  void loadJson() async {
    final String response =
        await rootBundle.loadString('assets/translate.json');
    data = await json.decode(response);
    print(data);
  }

  @override
  void initState() {
    loadJson();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('OCR In Flutter'),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _text.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: _read,
                    child: Text(
                      'Scanning',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    List<String> values = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _ocrCamera,
        waitTap: false,
        multiple: true,
        showText: true,
      );

      texts.forEach((val) => {
            values.add(val.value.toString()),
          });
      print("text");
      print(values);
      setState(() {
        _text = values;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewScreen(
                    text: values,
                    data: data,
                  )),
        );
      });
    } on Exception {
      texts.add(OcrText('Failed to recognize text'));
    }
  }
}
