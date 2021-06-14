import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ui/pdf/pdf.dart';
import 'package:flutter_ui/syncfusion/pdf_render1.dart';
import 'package:flutter_ui/syncfusion/pdf_viewer1.dart';
import 'package:flutter_ui/typeface_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Pdf(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 0;
  double _blurRadius = 0;
  double _spreadRadius = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildBoxShadow(
                  text: '左',
                  offset: Offset(-_value, 0.0),
                  blurRadius: _blurRadius,
                  spreadRadius: _spreadRadius),
              buildBoxShadow(
                  text: '上',
                  offset: Offset(0.0, -_value),
                  blurRadius: _blurRadius,
                  spreadRadius: _spreadRadius),
              // buildBoxShadow(
              //     text: '右',
              //     offset: Offset(_value, 0.0),
              //     blurRadius: _blurRadius,
              //     spreadRadius: _spreadRadius),
              // buildBoxShadow(
              //     text: '下',
              //     offset: Offset(0.0, _value),
              //     blurRadius: _blurRadius,
              //     spreadRadius: _spreadRadius),
              buildBoxShadow(
                  text: '左下',
                  offset: Offset(-_value, _value),
                  blurRadius: _blurRadius,
                  spreadRadius: _spreadRadius),
              buildBoxShadow(
                  text: '右下',
                  offset: Offset(_value, _value),
                  blurRadius: _blurRadius,
                  spreadRadius: _spreadRadius),
              Slider(
                  value: _value,
                  max: 8,
                  onChanged: (value) {
                    setState(() {
                      _value = NumUtil.getNumByValueDouble(value, 2);
                    });
                  }),
              Slider(
                  value: _blurRadius,
                  max: 8,
                  onChanged: (value) {
                    setState(() {
                      _blurRadius = NumUtil.getNumByValueDouble(value, 2);
                    });
                  }),
              Slider(
                  value: _spreadRadius,
                  max: 8,
                  onChanged: (value) {
                    setState(() {
                      _spreadRadius = NumUtil.getNumByValueDouble(value, 2);
                    });
                  }),
              Text(
                '关键代码：${"""
                
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent,
                    offset: Offset(1.0, 1.0), //阴影y轴偏移量
                    blurRadius: 1.0, //阴影模糊程度
                    spreadRadius: 1.0, //阴影扩散程度
                  )
                ],
              )"""}',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        child: Icon(Icons.navigate_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  // border: Border.all(width: 1, color: Colors.green,style: BorderStyle.solid),
  // border: Border(
  //       top: BorderSide(width: 16.0, color: Colors.amber),
  //        bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
  // ),
  Container buildBoxShadow(
      {String text, Offset offset, double blurRadius, double spreadRadius}) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.green,
            offset: offset ?? Offset(1.0, 1.0), //阴影x,y轴偏移量
            blurRadius: blurRadius ?? 1, //阴影模糊程度
            spreadRadius: spreadRadius ?? 1, //阴影扩散程度
          )
        ],
      ),
      child: Column(
        children: [
          Text("BoxShadow(绘制阴影)-$text"),
          Text("偏移量:$_value"),
          Text("阴影模糊程度:$_blurRadius"),
          Text("阴影扩散程度:$_spreadRadius"),
        ],
      ),
    );
  }

  _nextPage() {
    Navigator.push( //跳转到第二个界面
      context,
      MaterialPageRoute(builder: (context) => Typeface()),
    );
  }
}
