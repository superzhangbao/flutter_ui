import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HtmlToPdf extends StatefulWidget {
  @override
  _HtmlToPdfState createState() => _HtmlToPdfState();
}

class _HtmlToPdfState extends State<HtmlToPdf> {
  String generatedPdfFilePath;
  bool show = false;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  String name = "zhangbao";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter PDF Viewer'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () async {
                await generateExampleDocument();
                setState(() {
                  show = true;
                });
                // _saveAsFile(context, (constraints) { }, pageFormat)
              },
            ),
          ],
        ),
        body: Container(
          child: show ? SfPdfViewer.file(
            File('$generatedPdfFilePath'),
            key: _pdfViewerKey,
          ) : Center(
            child: ElevatedButton(
              child: Text("Open Generated PDF Preview"),
              onPressed: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PDFViewerScaffold(
                //         appBar: AppBar(title: Text("Generated PDF Document")),
                //         path: generatedPdfFilePath),
                //   ),
                // );
                await generateExampleDocument();
                setState(() {
                  show = true;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateExampleDocument() async {
    final htmlContent = """
   <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
  <style>
    *{
      padding: 0rem;
      margin: 0rem;
    }
    @media all and (min-width: 320px) and (max-width: 359px) {
      html{
        font-size: 85px;
      }
    }
    @media all and (min-width: 360px) and (max-width: 374px) {
      html{
        font-size: 96px;
      }
    }
    @media all and (min-width: 375px) {
      html{
        font-size: 100px;
      }
    }

    div{
      box-sizing: border-box;
    }
    .gray{
      color: #B7B7B7;
    }
    .bb{
      border-bottom: 1px solid #dddddd;
    }
    .error{
      color: red;
    }
    .page{
      width: 100%;
      background-color: white;
      overflow: hidden;
      zoom: 1;
      font-size: .20rem;
    }
    .content{
      width: 100%;
      margin-top: 0.0rem;
      padding: 0.3rem;
      background-color: white;
    }

    .report_top{
      width: 100%;
      height: auto;
    }
    .report_name{
      /*font-size: 0.4rem;*/
      font-weight: bold;
    }
    .report_top_info{
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: .2rem 0;
    }
    .report_top_info_left{
      display: flex;
      flex: 1 auto;
      height: 1.2rem;
      flex-direction: column;
      justify-content: space-between;
    }
    .report_top_info_right{
      width: 0.8rem;
      flex-shrink: 0;
      height: 1.2rem;
      margin-right: 0.6rem;
    }
    .report_top_info_left_item_label{
      font-weight: normal;
    }
    .report_top_info_left_item{
      display: flex;
      align-items: center;
      color: #333333;
      font-weight: bold;
      font-size: .18rem;
    }
    .report_top_info_left_item_value{
      margin-left: .15rem;
    }

    .box_item{
      width: 100%;
      height: auto;
      padding: 0.2rem;
      background-color: #f5f5f5;
      margin: .3rem auto;
    }
    .box_title{
      font-size: .16rem;
    }
    .row{
      width: 100%;
      display: flex;
      margin-top: .2rem;
    }
    .col-2{
      width: 20%;
      height: auto;
      flex-shrink: 1;
      flex-grow: 0;
      padding-right: 0.1rem;
    }
    .col-2-5{
      width: 25%;
      height: auto;
      flex-shrink: 1;
      flex-grow: 0;
      padding-right: 0.1rem;
    }
    .col-3-5{
      width: 35%;
      height: auto;
      flex-shrink: 1;
      flex-grow: 0;
      padding-right: 0.1rem;
    }
    .col-3{
      width: 30%;
      height: auto;
      flex-shrink: 1;
      flex-grow: 0;
      padding-right: 0.1rem;
    }
    .col-4{
      width: 40%;
      height: auto;
      flex-shrink: 1;
      flex-grow: 0;
      padding-right: 0.1rem;
    }
    .info_item{
      /*width: 100%;*/
      display: inline-flex;
      font-size: .115rem;
    }
    .info_item_label{
      margin-right: .1rem;
      width: auto;
      display: inline-flex;
      flex-wrap: nowrap;
      flex-shrink: 0;
    }

    .info_title{
      margin-top: .3rem;
    }
    .m-t-80{
      margin-top: 0.3rem;
    }

    .table{
      width: 100%;
      margin-top: 0.2rem;
      display:table-header-group;
    }

    .table thead tr{
      height: 0.4rem;
      line-height: 0.4rem;
      background-color: #D7CFD5;
    }
    .table tr, .table th{
      font-size: 0.1rem;
    }
    thead th:first-child, tbody td:first-child{
      padding-left: 0.1rem;
      box-sizing: border-box;
    }

    .table tbody tr{
      height: 0.6rem;
      line-height: 0.6rem;
    }
    .table tbody tr td{
      border-bottom: 1px solid #dddddd;
    }
  </style>
<!--  <script>-->
<!--    (function (doc, win) {-->
<!--      var docEl = doc.documentElement,-->
<!--        isIOS = navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),-->
<!--        dpr = isIOS ? Math.min(win.devicePixelRatio, 3) : 1,-->
<!--        scale = 1 / dpr,-->
<!--        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';-->
<!--      docEl.dataset.dpr = dpr;-->
<!--      var metaEl = doc.createElement('meta');-->
<!--      metaEl.name = 'viewport';-->
<!--      metaEl.content = 'initial-scale=' + scale + ',maximum-scale=' + scale + ', minimum-scale=' + scale;-->
<!--      docEl.firstElementChild.appendChild(metaEl);-->
<!--      var recalc = function () {-->
<!--        var width = docEl.clientWidth;-->
<!--        if (width / dpr > 750) {-->
<!--          width = 750 * dpr;-->
<!--        }-->
<!--        docEl.style.fontSize = 100 * (width / 750) + 'px';-->
<!--      };-->
<!--      recalc()-->
<!--      if (!doc.addEventListener) return;-->
<!--      win.addEventListener(resizeEvt, recalc, false);-->
<!--    })(document, window);-->
<!--  </script>-->
</head>
<body>
<div class="page">
  <div class="content">
    <div class="report_top bb">
      <div class="report_name">Device Health Check Report</div>
      <div class="report_top_info">
        <div class="report_top_info_left">
          <div class="report_top_info_left_item">
            <span class="report_top_info_left_item_label gray">Installer/service providers</span>
            <span class="report_top_info_left_item_value">lan jf</span>
          </div>
          <div class="report_top_info_left_item">
            <span class="report_top_info_left_item_label gray">Health Check Time</span>
            <span class="report_top_info_left_item_value">lan jf</span>
          </div>
          <div class="report_top_info_left_item">
            <span class="report_top_info_left_item_label gray">Export Time</span>
            <span class="report_top_info_left_item_value">lan jf</span>
          </div>
        </div>
        <img class="report_top_info_right" src="https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201409%2F08%2F20140908130732_kVXzh.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626457527&t=f8642f852cdb0c9af04c107d3d380d5d" alt="">
      </div>
    </div>

    <!--  Site Information  -->
    <div class="bb">
      <div class="box_item">
        <div class="box_title">Site Information</div>
        <div class="row">
          <div class="col-3">
            <div class="info_item" style="width: 100%;">
              <div class="info_item_label gray">Site Owner:</div>
              <div class="info_item_value">+86 18556369300</div>
            </div>
            <div class="info_item" style="width: 100%;">
              <div class="info_item_label gray">Mobile:</div>
              <div class="info_item_value">+86 18556369300</div>
            </div>
          </div>
          <div class="col-3">
            <div class="info_item" style="width: 100%;">
              <div class="info_item_label gray">Site Name:</div>
              <div class="info_item_value">AXPRO1.2.4-lanji </div>
            </div>
            <div class="info_item" style="width: 100%;">
              <div class="info_item_label gray">Email:</div>
              <div class="info_item_value">--</div>
            </div>
          </div>
          <div class="col-4">
            <div class="info_item">
              <div class="info_item_label gray">Site Address:</div>
              <div class="info_item_value">UJJJJJJ UJJJ Areee reeeUJJJJJJ UJJJ Areee reeeUJJJJJJ UJJJ Areee reee</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--  Site Information---end  -->

    <!--  DeviceName  -->
    <div class="info_title">Device Name:AX PRO</div>
    <div class="box_item">
      <div class="box_title">Device Information</div>
      <div class="row">
        <div class="info_item col-3-5">
          <div class="info_item_label gray">Device Name:</div>
          <div class="info_item_value">AX PRO</div>
        </div>
        <div class="info_item col-4">
          <div class="info_item_label gray">Last Inspected:</div>
          <div class="info_item_value">Mon Jun 7 18:45:58 2021</div>
        </div>
        <div class="info_item col-2-5">
          <div class="info_item_label gray">Device Id:</div>
          <div class="info_item_value">Q05109800</div>
        </div>
      </div>
      <div class="row">
        <div class="info_item col-3-5">
          <div class="info_item_label gray">Device Type:</div>
          <div class="info_item_value">Alarm Device</div>
        </div>
        <div class="info_item col-4">
          <div class="info_item_label gray">Firmware Version:</div>
          <div class="info_item_value">V1.2.4</div>
        </div>
      </div>
      <div class="row">
        <div class="info_item col-3-5">
          <div class="info_item_label gray">Device Model:</div>
          <div class="info_item_value">DS_PWA64-L-WB</div>
        </div>
        <div class="info_item col-4col-4">
          <div class="info_item_label gray">Device Serial No.:</div>
          <div class="info_item_value">Q05109800</div>
        </div>
      </div>
    </div>
    <!--  DeviceName---end  -->

    <div class="box_item">
      <div class="box_title">Panel Status [PASS]</div>
      <div class="row">
        <div class="info_item col-3-5">
          <div class="info_item_label gray">Work Status:</div>
          <div class="info_item_value">All Disarm</div>
        </div>
        <div class="info_item col-4">
          <div class="info_item_label gray">Connection Between Panel/Hub and Platform:</div>
          <div class="info_item_value">Online</div>
        </div>
        <div class="info_item col-2-5">
          <div class="info_item_label gray">Cellular Data Used:</div>
          <div class="info_item_value">0 M</div>
        </div>
      </div>
      <div class="row">
        <div class="info_item col-3-5">
          <div class="info_item_label gray">Cellular Signal Strength:</div>
          <div class="info_item_value error">Disconnected</div>
        </div>
        <div class="info_item col-4">
          <div class="info_item_label gray">Wi-Fi Signal Strength:</div>
          <div class="info_item_value">Disconnected</div>
        </div>
        <div class="info_item col-2-5">
          <div class="info_item_label gray">Network Cable:</div>
          <div class="info_item_value">OK</div>
        </div>
      </div>
      <div class="row">
        <div class="info_item col-3-5">
          <div class="info_item_label gray">Battery Level:</div>
          <div class="info_item_value error">OK</div>
        </div>
        <div class="info_item col-4">
          <div class="info_item_label gray">ARC Connection Status:</div>
          <div class="info_item_value">Not Enabled(1),Not Enabled(2)</div>
        </div>
      </div>

<div class="box_title m-t-80">Panel Status <span class="error">[NOT PASS]</span></div>

<table class="table" cellspacing="0">
<thead class="thead">
<tr>
<th align="left" width="100">Results</th>
<th align="left"width="120">Name</th>
<th align="left" width="120">Type</th>
<th align="left" width="120">Tampering Status</th>
<th align="left" width="60">Bypass</th>
<th align="left" width="60">Polling</th>
<th align="left" width="100">Battery Level</th>
<th align="left" width="140">RF Signal Strength</th>
</tr>
</thead>
<tbody>
<tr>
<td class="error">NOT PASS</td>
<td>Wireless Zone 1</td>
<td>Wireless Zone</td>
<td class="error">Yes</td>
<td>No</td>
<td class="error">Offline</td>
<td>OK</td>
<td>--</td>
</tr>
<tr>
<td class="error">NOT PASS</td>
<td>Wireless Zone 1</td>
<td>Wireless Zone</td>
<td class="error">Yes</td>
<td>No</td>
<td class="error">Offline</td>
<td>OK</td>
<td>--</td>
</tr>
<tr>
<td class="error">NOT PASS</td>
<td>Wireless Zone 1</td>
<td>Wireless Zone</td>
<td class="error">Yes</td>
<td>No</td>
<td class="error">Offline</td>
<td>OK</td>
<td>--</td>
</tr>
<tr>
<td class="error">NOT PASS</td>
<td>Wireless Zone 1</td>
<td>Wireless Zone</td>
<td class="error">Yes</td>
<td>No</td>
<td class="error">Offline</td>
<td>OK</td>
<td>--</td>
</tr>
<tr>
<td class="error">NOT PASS</td>
<td>Wireless Zone 1</td>
<td>Wireless Zone</td>
<td class="error">Yes</td>
<td>No</td>
<td class="error">Offline</td>
<td>OK</td>
<td>--</td>
</tr>
<tr>
<td class="error">NOT PASS</td>
<td>Wireless Zone 1</td>
<td>Wireless Zone</td>
<td class="error">Yes</td>
<td>No</td>
<td class="error">Offline</td>
<td>OK</td>
<td>--</td>
</tr>
</tbody>
</table>
      
    </div>
  </div>
</div>
</body>
</html>
    """;


    // String testContent = await rootBundle.loadString("assets/test.html");


    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
    print('generatedPdfFilePath:$generatedPdfFilePath');
  }
}

// min-height: 100vh;

