import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/models/statuscountwraper.dart';
import 'package:taks_app/presetetion/data/models/takslistwraper.dart';
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
  bool statusccountprosses = false;
  Taksstatuscountwraper _taksstatuscountwraper = Taksstatuscountwraper();
  Takslistwraper _newtakslistwraper = Takslistwraper();
  bool newtakslistprosses = false;
  bool deleteTaskprosses = false;
  bool updateTaskStatus = false;
  @override
  void initState() {
    // TODO: implement initState
    getstatuscount();
    getnewtakslist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: backroundwidget(
        child: Column(children: [
          countersection,
          Expanded(
              child: Visibility(
            visible: newtakslistprosses == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: RefreshIndicator(
              onRefresh: () async {
                getnewtakslist();
                getstatuscount();
              },
              child: ListView.builder(
                itemCount: _newtakslistwraper.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _newtakslistwraper.data![index].title.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _newtakslistwraper.data![index].description
                                  .toString(),
                            ),
                            Text(
                              'Date : ${_newtakslistwraper.data![index].createdDate}',
                            ),
                            Row(
                              children: [
                                Chip(
                                  label: Text(_newtakslistwraper
                                      .data![index].status
                                      .toString()),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      showstatus(
                                          _newtakslistwraper.data![index].sId);
                                    },
                                    icon: Visibility(
                                        visible: updateTaskStatus == false,
                                        replacement: Center(
                                            child: CircularProgressIndicator()),
                                        child: Icon(Icons.edit))),
                                IconButton(
                                    onPressed: () {
                                      deleteTask(
                                          _newtakslistwraper.data![index].sId!);
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
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => add(),
              ));
          if (result) {
            getnewtakslist();
            getstatuscount();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget get countersection {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
            visible: statusccountprosses == false,
            replacement: LinearProgressIndicator(),
            child: RefreshIndicator(
              onRefresh: () {
                return getnewtakslist();
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _taksstatuscountwraper.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return countercard(
                      amount: _taksstatuscountwraper.data![index].sum ?? 0,
                      txt: _taksstatuscountwraper.data![index].sId ?? '');
                },
              ),
            )),
      ),
    );
  }

  Future<void> getstatuscount() async {
    statusccountprosses = true;
    setState(() {});
    final respons = await NetworkCaller.getRequist(Urls.newtaskStatusCount);
    if (respons.issucsees) {
      _taksstatuscountwraper =
          Taksstatuscountwraper.fromJson(respons.responsbody);
      if (!mounted) {
        return;
      }
      statusccountprosses = false;
      setState(() {});
    } else {
      statusccountprosses = false;
      setState(() {});
      if (mounted) {
        sncakbarmameg(context, 'your taks status count faild');
      }
    }
  }

  Future<void> getnewtakslist() async {
    newtakslistprosses = true;
    if (!mounted) {
      return;
    }
    setState(() {});
    final respnons = await NetworkCaller.getRequist(Urls.newlistTaskByStatus);
    if (respnons.issucsees) {
      _newtakslistwraper = Takslistwraper.fromJson(respnons.responsbody);
      newtakslistprosses = false;
      if (mounted) {
        setState(() {});
      }
    } else {
      statusccountprosses = false;
      setState(() {});
      if (mounted) {
        sncakbarmameg(context, 'your new taks api call is faild');
      }
    }
  }

  Future<void> deleteTask(String id) async {
    deleteTaskprosses = true;
    setState(() {});
    final respons = await NetworkCaller.getRequist(Urls.deleteTask(id));
    deleteTaskprosses = false;
    if (respons.issucsees) {
      getnewtakslist();
      getstatuscount();
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
      getnewtakslist();
      getstatuscount();
    } else {
      if (mounted) {
        setState(() {});
        sncakbarmameg(context, 'update');
      }
    }
  }
}
