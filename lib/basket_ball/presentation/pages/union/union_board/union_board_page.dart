
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_branches.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_department_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_year_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_head_Entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../../injection.dart';

class UnionBoardPage extends StatefulWidget {
  UnionBoardPage({Key key}) : super(key: key);

  @override
  _UnionBoardPageState createState() {
    return _UnionBoardPageState();
  }
}

class _UnionBoardPageState extends State<UnionBoardPage> {
  bool showManagement = false;

  bool showManagements = false;

  bool showHeaders = false;

  bool showBranches = false;

  GetManagerHeadEntities getManagerHeadEntities = GetManagerHeadEntities(data: List());
  GetManagerAccordingToDepartmentEntities getManagerAccordingToDepartmentEntities = GetManagerAccordingToDepartmentEntities(data: List());
GetManagerAccordingtoBranchesEntities getManagerAccordingtoBranchesEntities = GetManagerAccordingtoBranchesEntities(data: List());
  GetManagerAccordingtoYearEntities getManagerAccordingtoYearEntities = GetManagerAccordingtoYearEntities(data: List());
getData()async{
  /*  var response = await sl<Cases>().getManagersHead();
    if (response is GetManagerHeadEntities) {
      setState(() {
        getManagerHeadEntities = response;
      });
    }  else if (response is ResponseModelFailure) {
      print(response.message);
    }  else{
      print("Error Connection");
    }*/
    var responseHead = await sl<Cases>().getManagersAccordingToDepartments();
    if (responseHead is GetManagerAccordingToDepartmentEntities) {
      setState(() {
        getManagerAccordingToDepartmentEntities = responseHead;
      });
    }  else if (responseHead is ResponseModelFailure) {
      print(responseHead.message);
    }  else{
      print("Error Connection");
    }
    var responseBranches = await sl<Cases>().getManagerAccordingToBranches();
    if (responseBranches is GetManagerAccordingtoBranchesEntities) {
      setState(() {
        getManagerAccordingtoBranchesEntities = responseBranches;
      });
    }  else if (responseBranches is ResponseModelFailure) {
      print(responseBranches.message);
    }  else{
      print("Error Connection");
    }
    var responseYear = await sl<Cases>().getManagerAccordingToYear();
    if (responseYear is GetManagerAccordingtoYearEntities) {
      setState(() {
        getManagerAccordingtoYearEntities = responseYear;
      });
    }  else if (responseYear is ResponseModelFailure) {
      print(responseYear.message);
    }  else{
      print("Error Connection");
    }
  }

  @override
  void initState() {
    super.initState();
  //  getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 50),
              child: Column(
                children: [
                  ListTile(
                    onTap: ()async{
                      if(getManagerHeadEntities.status == null){
                        ProgressDialog dialog = ProgressDialog(context);
                        dialog.show();
                        var response = await sl<Cases>().getManagersHead();
                        dialog.hide();
                        if (response is GetManagerHeadEntities) {
                          dialog.hide();
                          setState(() {
                            getManagerHeadEntities = response;
                            showHeaders = !showHeaders;
                            if (showManagements) {
                              showManagements = !showManagements;
                            }
                            if (showManagement) {
                              showManagement = !showManagement;
                            }
                            if (showBranches) {
                              showBranches = !showBranches;
                            }
                          });
                        } else if (response is ResponseModelFailure) {
                          dialog.hide();
                          print(response.message);
                        } else {
                          dialog.hide();
                          print("Error Connection");
                        }
                      }else{
                        setState(() {
                          showHeaders = !showHeaders;
                          if (showManagements) {
                            showManagements = !showManagements;
                          }
                          if (showManagement) {
                            showManagement = !showManagement;
                          }
                          if (showBranches) {
                            showBranches = !showBranches;
                          }
                        });
                      }
                    },
                    leading: Container(
                      width: 10,
                      height: 50,
                      color: Color(0xffE31E24),
                    ),
                    title: Text(
                      "مجلس ادارة الإتحاد",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showHeaders?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                  ),
                  ...getManagerHeadEntities.data.map((e) => showHeaders ? Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(height: MediaQuery.of(context).size.height / 5,
                            child: Image.network(e.thumb),
                          ),
                        ),
                        Expanded(
                            flex: 2
                            ,child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 10),
                                //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                child: Text("${e.title}",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width / 27,fontWeight: FontWeight.bold),)),
                            SizedBox(height: 20,),
                            Text("${e.position}",style: TextStyle(color: Colors.grey[700],fontSize: MediaQuery.of(context).size.width / 30,),),
                            SizedBox(height: 10,),
                            Text("",style: TextStyle(color: Colors.grey),),
                          ],
                        )),
                      ],
                    ),
                  ):Container()).toList(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 50),
              child: Column(
                children: [
                  ListTile(
                    onTap: ()async{
                      if(getManagerAccordingToDepartmentEntities.status == null){
                        ProgressDialog dialog = ProgressDialog(context);
                        dialog.show();
                        var response = await sl<Cases>().getManagersAccordingToDepartments();
                        dialog.hide();
                        if (response is GetManagerAccordingToDepartmentEntities) {
                          dialog.hide();
                          setState(() {
                            getManagerAccordingToDepartmentEntities = response;
                            showManagement = !showManagement;
                            if (showManagements) {
                              showManagements = !showManagements;
                            }
                            if (showHeaders) {
                              showHeaders = !showHeaders;
                            }
                            if (showBranches) {
                              showBranches = !showBranches;
                            }
                          });
                        } else if (response is ResponseModelFailure) {
                          dialog.hide();
                          print(response.message);
                        } else {
                          dialog.hide();
                          print("Error Connection");
                        }
                      }else{
                        setState(() {
                          showManagement = !showManagement;
                          if (showManagements) {
                            showManagements = !showManagements;
                          }
                          if (showHeaders) {
                            showHeaders = !showHeaders;
                          }
                          if (showBranches) {
                            showBranches = !showBranches;
                          }
                        });
                      }
                    },
                    leading: Container(
                      width: 10,
                      height: 50,
                      color: Color(0xffE31E24),
                    ),
                    title: Text(
                      " إدارات الإتحاد",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showManagement?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                  ),
                  ...getManagerAccordingToDepartmentEntities.data.map((e) => showManagement ? Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(height: MediaQuery.of(context).size.height / 5,
                            child: Image.network(e.thumb),
                          ),
                        ),
                        Expanded(
                            flex: 2
                            ,child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${e.title}",style: TextStyle(color: Colors.black,fontSize:  MediaQuery.of(context).size.width / 27,fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,),
                            Text("${e.position}",style: TextStyle(color: Colors.grey[700],fontSize:  MediaQuery.of(context).size.width / 30,),),
                            SizedBox(height: 10,),
                            Text("",style: TextStyle(color: Colors.grey),),
                          ],
                        )),
                      ],
                    ),
                  ):Container()).toList(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 50),
              child: Column(
                children: [
                  ListTile(
                    onTap: ()async{
                      if(getManagerAccordingtoBranchesEntities.status == null){
                        ProgressDialog dialog = ProgressDialog(context);
                        dialog.show();
                        var response = await sl<Cases>().getManagerAccordingToBranches();
                        dialog.hide();
                        if (response is GetManagerAccordingtoBranchesEntities) {
                          dialog.hide();
                          setState(() {
                            getManagerAccordingtoBranchesEntities = response;
                            showBranches = !showBranches;
                            if (showManagements) {
                              showManagements = !showManagements;
                            }
                            if (showHeaders) {
                              showHeaders = !showHeaders;
                            }
                            if (showManagement) {
                              showManagement = !showManagement;
                            }
                          });
                        } else if (response is ResponseModelFailure) {
                          dialog.hide();
                          print(response.message);
                        } else {
                          dialog.hide();
                          print("Error Connection");
                        }
                      }else{
                        setState(() {
                          showBranches = !showBranches;
                          if (showManagements) {
                            showManagements = !showManagements;
                          }
                          if (showHeaders) {
                            showHeaders = !showHeaders;
                          }
                          if (showManagement) {
                            showManagement = !showManagement;
                          }
                        });
                      }
                    },
                    leading: Container(
                      width: 10,
                      height: 50,
                      color: Color(0xffE31E24),
                    ),
                    title: Text(
                      "الفروع",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showBranches?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                  ),
                  ...getManagerAccordingtoBranchesEntities.data.map((e) => showBranches ?InkWell(
                    onTap: (){
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SolidBottomSheet(
                                maxHeight: MediaQuery.of(context).size.height / 1.2,
                                minHeight: MediaQuery.of(context).size.height / 2,
                                headerBar: Container(
                                  height: 50,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 10,left: 10),
                                  child: Text("${e.title}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                  color: Colors.white,
                                ), body: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: ListView.builder(itemCount: e.managers.length,itemBuilder: (context,index){
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Container(height: MediaQuery.of(context).size.height / 5,
                                            child: Image.network(e.managers[index].thumb),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2
                                            ,child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(right: 10),
                                                //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                child: Text("${e.managers[index].title}",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width / 27,fontWeight: FontWeight.bold),)),
                                            SizedBox(height: 20,),
                                            Text("${e.managers[index].position}",style: TextStyle(color: Colors.grey[700],fontSize: MediaQuery.of(context).size.width / 30,),),
                                            SizedBox(height: 10,),
                                            Text("",style: TextStyle(color: Colors.grey),),
                                          ],
                                        )),
                                      ],
                                    ),
                                  );
                                },),
                              ),
                            ));
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 50),
                      alignment: Alignment.centerRight,
                      child: Text("${e.title}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
                    ),
                  ):Container()),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 50),
              child: Column(
                children: [
                  ListTile(
                    onTap: ()async{
                      if(getManagerAccordingtoYearEntities.status == null){
                        ProgressDialog dialog = ProgressDialog(context);
                        dialog.show();
                        var response = await sl<Cases>().getManagerAccordingToYear();
                        dialog.hide();
                        if (response is GetManagerAccordingtoYearEntities) {
                          dialog.hide();
                          setState(() {
                            getManagerAccordingtoYearEntities = response;
                            showManagements = !showManagements;
                            if (showManagement) {
                              showManagement = !showManagement;
                            }
                            if (showHeaders) {
                              showHeaders = !showHeaders;
                            }
                            if (showBranches) {
                              showBranches = !showBranches;
                            }
                          });
                        } else if (response is ResponseModelFailure) {
                          dialog.hide();
                          print(response.message);
                        } else {
                          dialog.hide();
                          print("Error Connection");
                        }
                      }else{
                        setState(() {
                          showManagements = !showManagements;
                          if (showManagement) {
                            showManagement = !showManagement;
                          }
                          if (showHeaders) {
                            showHeaders = !showHeaders;
                          }
                          if (showBranches) {
                            showBranches = !showBranches;
                          }
                        });
                      }
                    },
                    leading: Container(
                      width: 10,
                      height: 50,
                      color: Color(0xffE31E24),
                    ),
                    title: Text(
                      "رؤساء الاتحاد السابقين",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showManagements?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                  ),
                 ...getManagerAccordingtoYearEntities.data.map((e) =>  showManagements ?Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      onTap: (){
                        print(e.toJson());
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SolidBottomSheet(
                                  maxHeight: MediaQuery.of(context).size.height / 1.2,
                                  minHeight: MediaQuery.of(context).size.height / 2,
                                  headerBar: Container(
                                    height: 50,
                                    padding: EdgeInsets.only(right: 10,left: 10),
                                    alignment: Alignment.centerRight,
                                    child: Text("${e.title}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                    color: Colors.white,
                                  ), body: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: ListView.builder(itemCount: e.managers.length,itemBuilder: (context,index){
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 2
                                              ,child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(right: 10),
                                                  //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                  child: Text("${e.managers[index].title}",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width / 25,fontWeight: FontWeight.bold),)),
                                              SizedBox(height: 20,),
                                              Text("",style: TextStyle(color: Colors.grey[700],fontSize: MediaQuery.of(context).size.width / 30,),),
                                              SizedBox(height: 10,),
                                              Text("",style: TextStyle(color: Colors.grey),),
                                            ],
                                          )),
                                          Flexible(
                                            flex: 2,
                                            child: Container(height: MediaQuery.of(context).size.height / 5,
                                              width: MediaQuery.of(context).size.width / 3,
                                              child: Image.network(e.managers[index].thumb,fit: BoxFit.fill,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },),
                                ),
                              ));
                            });
                      },
                      leading:Container(width: 20,height: 50,color: Color(0xffE31E24),),
                      title: Text("${e.title}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ):Container()),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}