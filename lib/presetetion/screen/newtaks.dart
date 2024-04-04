import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:taks_app/presetetion/data/controlers/newtaks.dart';
import 'package:taks_app/presetetion/data/controlers/taks_by_status_count.dart';
import 'package:taks_app/presetetion/data/models/statuscountwraper.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/add.dart';
import 'package:taks_app/presetetion/screen/profileappbar.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/countercar.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class newtaks extends StatefulWidget {
  const newtaks({super.key});

  @override
  State<newtaks> createState() => _newtaksState();
}

class _newtaksState extends State<newtaks> {
  NewtaksControlers _newtaksControlers = Get.find<NewtaksControlers>();
  bool deleteTaskprosses = false;
  bool updateTaskStatus = false;
  TaksBystauscountcontroler _taksBystauscountcontroler =
      Get.find<TaksBystauscountcontroler>();
  @override
  void initState() {
    // TODO: implement initState
    _taksBystauscountcontroler.taksBystaus();
    _newtaksControlers.taksBystaus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: backroundwidget(
        child: body(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result = await Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => add(),
      //         ));
      //     if (result) {
      //       _newtaksControlers.taksBystaus();

      //       _taksBystauscountcontroler.taksBystaus();
      //     }
      //   },
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(Add());
          if (result) {
            _newtaksControlers.taksBystaus();

            _taksBystauscountcontroler.taksBystaus();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Column body() {
    return Column(children: [
      GetBuilder<TaksBystauscountcontroler>(builder: (_) {
        return countersection(
            _taksBystauscountcontroler.taksstatuscountwraper.data ?? []);
      }),
      Expanded(child: GetBuilder<NewtaksControlers>(builder: (_) {
        return Visibility(
          visible: _newtaksControlers.inProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: () async {
              _newtaksControlers.taksBystaus();
              _taksBystauscountcontroler.taksBystaus();
            },
            child: ListView.builder(
              itemCount:
                  _newtaksControlers.taksstatuscountwraper.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _newtaksControlers
                                .taksstatuscountwraper.data![index].title
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _newtaksControlers
                                .taksstatuscountwraper.data![index].description
                                .toString(),
                          ),
                          Text(
                            'Date : ${_newtaksControlers.taksstatuscountwraper.data![index].createdDate}',
                          ),
                          Row(
                            children: [
                              Chip(
                                label: Text(_newtaksControlers
                                    .taksstatuscountwraper.data![index].status
                                    .toString()),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    showstatus(_newtaksControlers
                                        .taksstatuscountwraper
                                        .data![index]
                                        .sId);
                                  },
                                  icon: Visibility(
                                      visible: updateTaskStatus == false,
                                      replacement: Center(
                                          child: CircularProgressIndicator()),
                                      child: Icon(Icons.edit))),
                              IconButton(
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (timeStamp) {
                                        deleteTask(_newtaksControlers
                                            .taksstatuscountwraper
                                            .data![index]
                                            .sId!);
                                      },
                                    );
                                  },
                                  icon: Visibility(
                                      visible: deleteTaskprosses == false,
                                      replacement: Center(
                                          child: CircularProgressIndicator()),
                                      child: Icon(Icons.delete))),
                            ],
                          )
                        ]),
                  ),
                );
              },
            ),
          ),
        );
      }))
    ]);
  }

  Widget countersection(List<Data> taksBystaus) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
            visible: _taksBystauscountcontroler.inProgress == false,
            replacement: LinearProgressIndicator(),
            child: RefreshIndicator(
              onRefresh: () {
                return _newtaksControlers.taksBystaus();
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: taksBystaus?.length ?? 0,
                itemBuilder: (context, index) {
                  return countercard(
                      amount: taksBystaus![index].sum ?? 0,
                      txt: taksBystaus[index].sId ?? '');
                },
              ),
            )),
      ),
    );
  }

  // Future<void> getstatuscount() async {
  //   statusccountprosses = true;
  //   setState(() {});
  //   final respons = await NetworkCaller.getRequist(Urls.newtaskStatusCount);
  //   if (respons.issucsees) {
  //     _taksstatuscountwraper =
  //         Taksstatuscountwraper.fromJson(respons.responsbody);
  //     if (!mounted) {
  //       return;
  //     }
  //     statusccountprosses = false;
  //     setState(() {});
  //   } else {
  //     statusccountprosses = false;
  //     setState(() {});
  //     if (mounted) {
  //       sncakbarmameg(context, 'your taks status count faild');
  //     }
  //   }
  // }

  // Future<void> getnewtakslist() async {
  //   newtakslistprosses = true;
  //   if (!mounted) {
  //     return;
  //   }
  //   setState(() {});
  //   final respnons = await NetworkCaller.getRequist(Urls.newlistTaskByStatus);
  //   if (respnons.issucsees) {
  //     _newtakslistwraper = Takslistwraper.fromJson(respnons.responsbody);
  //     newtakslistprosses = false;
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   } else {
  //     setState(() {});
  //     if (mounted) {
  //       sncakbarmameg(context, 'your new taks api call is faild');
  //     }
  //   }
  // }

  Future<void> deleteTask(String id) async {
    deleteTaskprosses = true;
    setState(() {});
    final respons = await NetworkCaller.getRequist(Urls.deleteTask(id));
    deleteTaskprosses = false;
    if (respons.issucsees) {
      _taksBystauscountcontroler.taksBystaus();
      _newtaksControlers.taksBystaus();
      setState(() {});
    } else {
      setState(() {});
      if (mounted) {
        sncakbarmameg(context, 'delet');
      }
    }
  }

  showstatus(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('status'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              title: Text('new'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('completed'),
              onTap: () {
                updatTaskStatus(id: id, status: 'Completed');
                Navigator.pop(context);
              },
              // trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('progress'),
              onTap: () {
                updatTaskStatus(id: id, status: 'Progress');
                Navigator.pop(context);
              },
              // trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('cancelled'),
              onTap: () {
                updatTaskStatus(id: id, status: 'Cancelled');
                Navigator.pop(context);
              },
              // trailing: Icon(Icons.check),
            )
          ]),
        );
      },
    );
  }

  Future<void> updatTaskStatus(
      {required String id, required String status}) async {
    updateTaskStatus = true;
    setState(() {});
    final respons = await NetworkCaller.getRequist(
        Urls.dupdateTaskStatuseleteTask(id, status));
    updateTaskStatus = false;
    if (respons.issucsees) {
      _newtaksControlers.taksBystaus();
      _taksBystauscountcontroler.taksBystaus();
    } else {
      if (mounted) {
        setState(() {});
        sncakbarmameg(context, 'update');
      }
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taks_app/presetetion/data/controlers/newtaks.dart';
// import 'package:taks_app/presetetion/data/controlers/taks_by_status_count.dart';
// import 'package:taks_app/presetetion/data/models/statuscountwraper.dart';
// import 'package:taks_app/presetetion/screen/add.dart';
// import 'package:taks_app/presetetion/screen/profileappbar.dart';
// import 'package:taks_app/presetetion/widget/countercar.dart';

// class newtaks extends StatefulWidget {
//   newtaks({super.key});

//   @override
//   State<newtaks> createState() => _newtaksState();
// }

// class _newtaksState extends State<newtaks> {
//   NewtaksControlers _newtaksControlers = Get.find<NewtaksControlers>();

//   TaksBystauscountcontroler _taksBystauscountcontroler =
//       Get.find<TaksBystauscountcontroler>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     _taksBystauscountcontroler.taksBystaus();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbar(context),
//       body: Column(
//         children: [
//           GetBuilder<TaksBystauscountcontroler>(builder: (_) {
//             return countersection(
//                 _taksBystauscountcontroler.taksstatuscountwraper.data ?? []);
//           })
//           ,
//           Expanded(
//             child:  ListView.builder(
//               itemCount:
//                   _newtaksControlers.taksstatuscountwraper.data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _newtaksControlers
//                                 .taksstatuscountwraper.data![index].title
//                                 .toString(),
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             _newtaksControlers
//                                 .taksstatuscountwraper.data![index].description
//                                 .toString(),
//                           ),
//                           Text(
//                             'Date : ${_newtaksControlers.taksstatuscountwraper.data![index].createdDate}',
//                           ),
//                           Row(
//                             children: [
//                               Chip(
//                                 label: Text(_newtaksControlers
//                                     .taksstatuscountwraper.data![index].status
//                                     .toString()),
//                               ),
//                               Spacer(),
//                               IconButton(
//                                   onPressed: () {
//                                     showstatus(_newtaksControlers
//                                         .taksstatuscountwraper
//                                         .data![index]
//                                         .sId);
//                                   },
//                                   icon: Visibility(
//                                       visible: updateTaskStatus == false,
//                                       replacement: Center(
//                                           child: CircularProgressIndicator()),
//                                       child: Icon(Icons.edit))),
//                               IconButton(onPressed: () {
//                                 WidgetsBinding.instance.addPostFrameCallback(
//                                   (timeStamp) {
//                                     deleteTask(_newtaksControlers
//                                         .taksstatuscountwraper
//                                         .data![index]
//                                         .sId!);
//                                   },
//                                 );
//                               }, icon: GetBuilder(builder: (_) {
//                                 return Visibility(
//                                     visible: deleteTaskprosses == false,
//                                     replacement: Center(
//                                         child: CircularProgressIndicator()),
//                                     child: Icon(Icons.delete));
//                               })),
//                             ],
//                           )
//                         ]),
//                   ),
//           )
//         ],

//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => add(),
//               ));
//           if (result) {
//             _newtaksControlers.taksBystaus();

//             _taksBystauscountcontroler.taksBystaus();
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget countersection(List<Data> taksBystaus) {
//     return SizedBox(
//       height: 120,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Visibility(
//             visible: false == false,
//             replacement: LinearProgressIndicator(),
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 // return _newtaksControlers.taksBystaus();
//               },
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: taksBystaus?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   return countercard(
//                       amount: taksBystaus![index].sum ?? 0,
//                       txt: taksBystaus[index].sId ?? '');
//                 },
//               ),
//             )),
//       ),
//     );
//   }
// }
