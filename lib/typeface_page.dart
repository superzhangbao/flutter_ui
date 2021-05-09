
import 'package:flutter/material.dart';
import 'package:flutter_ui/util.dart';
import 'package:flutter_ui/webp_page.dart';


class Typeface extends StatefulWidget {
  @override
  _TypefaceState createState() => _TypefaceState();
}

class _TypefaceState extends State<Typeface> {
  String _text = '字';
  String _enText = 'Fn';
  double _fontSize = 38;

  FontWeight _normal = FontWeight.normal;
  FontWeight _fontWeight500 = FontWeight.w500;
  FontWeight _fontWeight600 = FontWeight.w600;
  FontWeight _fontWeight700 = FontWeight.w700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter UI Demo-字体、字重'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('w500'),
                buildText(_normal),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(_fontWeight500),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(_fontWeight500,text: _enText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('w600'),
                buildText(_normal),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(_fontWeight600),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(_fontWeight600,text: _enText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('w700-Bold'),
                buildText(_normal),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(_fontWeight700),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(_fontWeight700,text: _enText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('自动转换'),
                buildText(_normal),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(fontWeightBold()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: buildText(fontWeightBold(),text: _enText),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  Text buildText(FontWeight fontWeight,{String text}) {
    return Text(
            text ?? _text,
            style: TextStyle(
              fontSize: _fontSize,
              fontWeight: fontWeight,
              // fontFamily: 'Source Han Sans'
              // fontFamily: 'Roboto'
              // fontFamily: "Courier"
            ),
          );
  }

  _nextPage() {
    Navigator.push( //跳转到第二个界面
      context,
      MaterialPageRoute(builder: (context) => WebpPage()),
    );
  }
}
