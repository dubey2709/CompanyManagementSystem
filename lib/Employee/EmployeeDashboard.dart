import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_system/Employee/UpdateEmployee.dart';

import 'AddEmployee.dart';
import '../Models/Company.dart';
import '../Models/Employee.dart';

class EmployeeDashboard extends StatefulWidget {
  EmployeeDashboard(this.cId, this.client);
  final int cId;
  final Client client;

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  List<Employee> employees = [];
  List<bool> hoverEdit = [];
  List<bool> hoverDelete = [];

  @override
  void initState() {
    _retrieveEmployees();
    super.initState();
  }

  _retrieveEmployees() async {
    employees = [];
    hoverEdit = [];
    hoverDelete = [];
    Response response = await widget.client.get(Uri.parse(
        'http://localhost:8000/api/v1/companies/${widget.cId}/employees/'));
    var decodeddata = response.body;
    var data = jsonDecode(decodeddata);
    data.forEach((element) {
      employees.add(Employee.fromJson(element));
      hoverEdit.add(false);
      hoverDelete.add(false);
    });

    setState(() {});
  }

  void deleteEmployee(int id) {
    widget.client
        .delete(Uri.parse('http://localhost:8000/api/v1/employees/$id/'));
    _retrieveEmployees();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width < 900 ? size.width * 2 : size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: true,
        title: Text(
          'Employee Management Dashboard',
          style: TextStyle(
              fontSize: 0.019 * width,
              color: Colors.white,
              fontFamily: 'Satisfy'),
        ),
        flexibleSpace: Container(
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/appbar3.gif'), fit: BoxFit.cover),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        leading: Icon(
          Icons.account_circle_rounded,
          size: 0.030 * width,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Employee - an asset for growth',
              textScaleFactor: 1,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 0.019 * width,
                  fontFamily: 'Lobster'),
            ),
            SizedBox(height: 0.004 * height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Strength of a company is each individual employee",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 0.012 * width,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewEmployee(widget.client, widget.cId)));
                    },
                    child: Center(
                      child: Text(
                        'Add Employee +',
                        style: TextStyle(
                            color: Colors.white, fontSize: 0.012 * width),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        elevation: MaterialStateProperty.all(5),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(05)))),
                  ),
                )
              ],
            ),
            SizedBox(height: 0.013 * height),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Text(
                      'SNo',
                      style: TextStyle(
                          fontSize: 0.012 * width, color: Colors.blueAccent),
                    ),
                    title: Text(
                      'Employee Name',
                      style: TextStyle(
                          fontSize: 0.012 * width, color: Colors.blueAccent),
                    ),
                    trailing: Text(
                      'Editing options',
                      style: TextStyle(
                          fontSize: 0.012 * width, color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 500,
                      width: width,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _retrieveEmployees();
                        },
                        child: employees.length != 0
                            ? ListView.builder(
                                itemCount: employees.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        tileColor:
                                            Colors.blueAccent.withOpacity(0.1),
                                        leading: Text('${index + 1}'),
                                        title: Text(
                                          employees[index].name +
                                              " - " +
                                              employees[index].position,
                                          style: TextStyle(
                                              fontSize: 0.012 * width,
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(employees[index].about,
                                            style: TextStyle(
                                                fontSize: 0.008 * width,
                                                color: Colors.black)),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MouseRegion(
                                              onEnter: (_) => setState(() =>
                                                  hoverEdit[index] = true),
                                              onExit: (_) => setState(() =>
                                                  hoverEdit[index] = false),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateEmployee(
                                                                widget.client,
                                                                employees[index]
                                                                    .id,
                                                                employees[index]
                                                                    .name,
                                                                employees[
                                                                        index]
                                                                    .email,
                                                                employees[index]
                                                                    .address,
                                                                employees[index]
                                                                    .about,
                                                                employees[index]
                                                                    .phone,
                                                                employees[index]
                                                                    .position,
                                                                widget.cId),
                                                      ));
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: hoverEdit[index]
                                                      ? Colors.blue
                                                      : Colors.black,
                                                  size: hoverEdit[index]
                                                      ? 25
                                                      : 20,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 0.010 * width),
                                            MouseRegion(
                                              onEnter: (_) => setState(() =>
                                                  hoverDelete[index] = true),
                                              onExit: (_) => setState(() =>
                                                  hoverDelete[index] = false),
                                              child: GestureDetector(
                                                onTap: () {
                                                  deleteEmployee(
                                                      employees[index].id);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: hoverDelete[index]
                                                      ? 25
                                                      : 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5)
                                    ],
                                  );
                                })
                            : Container(
                                child: Center(
                                  child: Text(
                                    'Currenty there is no Employee data\n'
                                    'Please click on add Employee to add entries of employee !!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 0.012 * width,
                                        color: Colors.redAccent),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
