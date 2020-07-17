//import 'dart:convert';
//import 'dart:io';
//import 'dart:typed_data';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:http/http.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
//
//class Load_Pdf_State extends StatefulWidget {
//
//  Load_Pdf_State();
//
//  @override
//  LoadPdfView createState() => LoadPdfView();
//}
//
//class LoadPdfView extends State<Load_Pdf_State> {
//  String path;
//  String textError='Loding...';
//
//  @override
//  void initState() {
//    super.initState();
//    loadPdf();
//  }
//
//  //xu ly file pdf
//  Future<String> get _localPath async {
//    final directory = await getApplicationDocumentsDirectory();
//
//    return directory.path;
//  }
//
//  Future<File> get _localFile async {
//    final path = await _localPath;
//    print('$path/teste.pdf');
//    return File('$path/teste.pdf');
//  }
//
//  Future<File> writeCounter(Uint8List stream) async {
//    final file = await _localFile;
//    // Write the file
//    return file.writeAsBytes(stream);
//  }
//
//  Future<Uint8List> fetchPost() async {
//    final response = await http.get('https://pdfhost.io/v/gv7QIsxQD_CNG_THC_CC_HNH_HC_LP_5.pdf');
//    final responseJson = response.bodyBytes;
//
//    return responseJson;
//  }
//
//  loadPdf() async {
//    if (path != null) {
//      print('load');
//    }
//
//    await writeCounter(await fetchPost());
//    path = (await _localFile).path;
//
//    if (!mounted) return;
//
//    setState(() {
//    });
//  }
//
//  Widget Pdf() {}
//
//  @override
//  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          "File đính kèm",
//        ),
////          ios: (_) => CupertinoNavigationBarData(
////            transitionBetweenRoutes: false,
////          ),
//      ),
//      body: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                if (path != null)
//                  Container(
//                    height: height,
//                    child: PdfViewer(
//                      filePath: path,
//                    ),
//                  )
//                else
//                  Center(
//                    child: Padding(padding: EdgeInsets.only(top: 20),
//                        child: Text(textError,style: TextStyle(fontSize: 16),),),
//                  )
//              ],
//            )
//      ),
//
////      ),
//    );
//  }
//}
