import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageLoadListenerSamplePage extends StatefulWidget {
  @override
  _ImageLoadListenerSamplePageState createState() =>
      _ImageLoadListenerSamplePageState();
}

class _ImageLoadListenerSamplePageState
    extends State<ImageLoadListenerSamplePage> {
  var text = "清除缓存";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Load Listener"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.network(
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201612%2F05%2F20161205214806_CYPLt.gif&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1623168041&t=748b7c052fb4450255dfa7fe8753a0af",
            width: MediaQuery.of(context).size.width,
            height: 400,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              int currentLength = loadingProgress.cumulativeBytesLoaded;
              int totalLength = loadingProgress.expectedTotalBytes;
              print("$currentLength/$totalLength from network");

              return CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              );
            },
          ),
          TextButton(onPressed: () => _clearCache(context), child: Text(text))
        ],
      ),
    );
  }

  /// 清理缓存（为了测试缓存）
  _clearCache(BuildContext context) {
    PaintingBinding.instance.imageCache.clear();
    print("---_clearCache-->");
  }
}
