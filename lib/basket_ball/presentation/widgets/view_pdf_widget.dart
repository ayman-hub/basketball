import 'dart:async';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:open_file/open_file.dart';
//import 'package:native_pdf_renderer/native_pdf_renderer.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'loading_widget.dart';
import 'package:http/http.dart' as http;

class ViewPdfWidget extends StatefulWidget {
  ViewPdfWidget({Key key, this.title, this.url}) : super(key: key);
  String url;
  String title;

  @override
  _ViewPdfWidgetState createState() {
    return _ViewPdfWidgetState();
  }
}

class _ViewPdfWidgetState extends State<ViewPdfWidget> {
  bool showProgress = true;

  String path = "";

  MemoryImage image ;

  PdfController pdfController ;

  bool showError = false;


  @override
  void initState() {
    super.initState();
    print('path:: $path');
    downloadStreamController = StreamController.broadcast();
  //  getData();
    testDownloadPdf(widget.url, widget.title);
  }

  @override
  void dispose() {
    super.dispose();
    disposeDownloadStreamController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: Container(),
            title: Text(
              "${widget.title}",
              style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            actions: [
              backIconAction(() {
                Get.back();
              })
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: pdfController  == null
                        ?showError?errorContainer(context, (){
                          testDownloadPdf(widget.url, widget.title);
                          setState(() {
                            showError = false;
                          });
                    }): StreamBuilder(
                            stream: downloadStreamController.stream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              print('snapshot:: ${snapshot.data}');
                              if (snapshot.hasError)
                                return errorContainer(context, () {});
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Container();
                                case ConnectionState.waiting:
                                  return getLoadingContainer(context);
                                case ConnectionState.active:
                                  return  Container(
                                    alignment: Alignment.center,
                                    child: Text('${snapshot.data}',style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.bold),),
                                  );
                                case ConnectionState.done:
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text('${snapshot?.data??"0.0"}',style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.bold),),
                                  );
                              }
                              return errorContainer(context, () {});
                            })
                        : PdfView(
                      controller: pdfController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
               /* showProgress
                    ? Container(
                        height: 50,
                        child: getLoadingContainer(context),
                      )
                    :*/ InkWell(
                        onTap: () async {
                      if(path != ''){
                        OpenFile.open(path);
                      }else{
                        testDownloadPdf(widget.url, widget.title);
                      }
                        },
                        child: Container(
                          width: 250,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: staticColor),
                          child: TextButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                              label: Text(
                                'تحميل',
                                style: GoogleFonts.cairo(
                                    color: Colors.white, fontSize: 12),
                              )),
                        ),
                      ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
getData()async{

}

  /*Future<String> dowloadData() async {
    if (widget.url != "") {
      if(path == ""){
      *//*  setState(() {
          showProgress = true;
        });*//*
        var tempDir = await getTemporaryDirectory();
        String fullPath = tempDir.path + "${widget.url
            .split("/")
            .last}";
        print('full path ${fullPath}');
        var done = await testDownloadPdf(widget.url, "${widget.title}");
        print('done $done');
        if (done != null) {
          print('done:: $done');
          if (done is String) {
            setState(() {
              path = done;
            });
            return done;
          }
         *//* setState(() {
            showProgress = false;
          });*//*
        }
      } else {
     // showToast(context, "لا يوجد ملف للتحميل");
    }
  }else{
      return path;
    }
  }
*/
  testDownloadPdf(String url,String name)async{
    print("$url     $name");
    var syncPath = '${(await getApplicationDocumentsDirectory()).path}/$name.pdf';
    bool exist =  await File(syncPath).exists();
    if(!exist){
      int _total = 0, _received = 0;
      http.StreamedResponse _response;
      final List<int> _bytes = [];

      try {
        // download
        _response =
            await http.Client().send(http.Request('GET', Uri.parse('$url')));
        _total = _response.contentLength ?? 0;
        _response.stream.listen((value) {
          _bytes.addAll(value);
          _received += value.length;
          String streamValue = '${_received ~/ 1024}/${_total ~/ 1024} KB';
          print('${_received ~/ 1024}/${_total ~/ 1024} KB');
          downloadStreamController.add(streamValue);
        }).onDone(() async {
          final file = File(
              '${(await getApplicationDocumentsDirectory()).path}/$name.pdf');
          await file.writeAsBytes(_bytes);
          if(file != null){
            setState(() {
              path = file.path;
              pdfController = PdfController(
                document: PdfDocument.openFile(path),
              );
            });
          }
          getData();
          print('file;: $file');
        });

       // return _file.path;
      } catch (e) {
        print('download error $e');
        setState(() {
          showError = true;
        });
        return false;
      }
    }else{
      setState(() {
        path = syncPath;
      pdfController =   PdfController(
          document: PdfDocument.openFile(syncPath),
        );
      });
    }
  }
}
