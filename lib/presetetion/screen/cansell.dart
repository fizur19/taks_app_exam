import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/models/takslistwraper.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/profileappbar.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class cansell extends StatefulWidget {
  const cansell({super.key});

  @override
  State<cansell> createState() => _cansellState();
}

class _cansellState extends State<cansell> {
  bool listTaskByStatus = false;
  bool deleteTaskprosses = false;
  bool updateTaskStatus = false;
  Takslistwraper _takslistwraper = Takslistwraper();
  @override
  void initState() {
    // TODO: implement initState
    TaskByStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: backroundwidget(
        child: Column(children: [
          Expanded(
              child: Visibility(
            visible: listTaskByStatus == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: RefreshIndicator(
              onRefresh: () async {
                TaskByStatus();
              },
              child: ListView.builder(
                itemCount: _takslistwraper.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _takslistwraper.data![index].title!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _takslistwraper.data![index].description!,
                            ),
                            Text(
                              'Date : ${_takslistwraper.data![index].createdDate}',
                            ),
                            Row(
                              children: [
                                Chip(
                                  label: Text(_takslistwraper
                                      .data![index].status
                                      .toString()),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      showstatus(
                                          _takslistwraper.data![index].sId);
                                    },
                                    icon: Visibility(
                                        visible: updateTaskStatus == false,
                                        replacement: Center(
                                            child: CircularProgressIndicator()),
                                        child: Icon(Icons.edit))),
                                IconButton(
                                    onPressed: () {
                                      deleteTask(
                                          _takslistwraper.data![index].sId!);
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
    );
  }

  Future<void> TaskByStatus() async {
    listTaskByStatus = true;
    if (!mounted) {
      return;
    }
    setState(() {});
    final reppons =
        await NetworkCaller.getRequist(Urls.CancelledlistTaskByStatus);

    if (reppons.issucsees) {
      _takslistwraper = Takslistwraper.fromJson(reppons.responsbody);
      listTaskByStatus = false;
      if (!mounted) {
        return;
      }
      setState(() {});
    } else {
      listTaskByStatus = false;
      setState(() {});
      if (mounted) {
        sncakbarmameg(context, 'your taks status count faild');
      }
    }
  }

  Future<void> deleteTask(String id) async {
    deleteTaskprosses = true;
    setState(() {});
    final respons = await NetworkCaller.getRequist(Urls.deleteTask(id));
    deleteTaskprosses = false;
    if (respons.issucsees) {
      TaskByStatus();
    } else {
      deleteTaskprosses = false;
      setState(() {});
      if (mounted) {
        sncakbarmameg(context, 'delet');
      }
    }
  }

  // update status
  Future<void> updatTaskStatus(
      {required String id, required String status}) async {
    updateTaskStatus = true;
    setState(() {});
    final respons = await NetworkCaller.getRequist(
        Urls.dupdateTaskStatuseleteTask(id, status));
    updateTaskStatus = false;
    if (respons.issucsees) {
      TaskByStatus();
    } else {
      if (mounted) {
        setState(() {});
        sncakbarmameg(context, 'update');
      }
    }
  }

  // show status bootam model
  showstatus(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('status'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              onTap: () {
                updatTaskStatus(id: id, status: 'New');
                Navigator.pop(context);
              },
              title: Text('new'),
              // trailing: Icon(Icons.check),
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
                Navigator.pop(context);
              },
              trailing: Icon(Icons.check),
            )
          ]),
        );
      },
    );
  }
}
