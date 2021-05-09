import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/load_listener.dart';
class WebpPage extends StatefulWidget {
  @override
  _WebpPageState createState() => _WebpPageState();
}

class _WebpPageState extends State<WebpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter UI Demo-webp'),
      ),
      body: Container(
        child: Column(
          children: [
            Image.asset('assets/testwebp.webp'),
            Image.asset('assets/testgif.gif'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  _nextPage() {
    Navigator.push(
      //跳转到第二个界面
      context,
      MaterialPageRoute(builder: (context) => ImageLoadListenerSamplePage()),
    );
  }
}

