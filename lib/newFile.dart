import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  // const NewScreen({ Key? key }) : super(key: key);
  final text;
  final data;

  NewScreen({this.text, this.data});
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  List convertedList = [];
  convert(List text, Map data) {
    text.toList().forEach((element) {
      element.split("\\W+").forEach((value) {
        print(value);
        print(data[value]);
        convertedList.add(data[value]);
      });
    });
  }

  @override
  void initState() {
    print('dataobject');
    print(widget.data['begierig']);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(widget.text.toString()),
            ),
            MaterialButton(
                child: Text('convert'),
                onPressed: () {
                  convert(widget.text, widget.data);
                  setState(() {});
                }),
            Container(
              child: Text(convertedList.toString()),
            )
          ],
        ),
      ),
    );
  }
}
