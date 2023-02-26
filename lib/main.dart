import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:management_system/Company/AddCompany.dart';
import 'package:management_system/Employee/EmployeeDashboard.dart';
import 'package:management_system/Company/UpdateCompany.dart';
import 'Models/Company.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Management Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Client client = Client();
  List<Company> companies = [];
  List<bool> hoverEdit = [];
  List<bool> hoverDelete = [];
  int editIcon = 20;

  @override
  void initState() {
    _retrieveRecords();
    super.initState();
  }

  _retrieveRecords() async {
    companies = [];
    hoverEdit = [];
    hoverDelete = [];
    Response response =
        await client.get(Uri.parse('http://localhost:8000/api/v1/companies/'));
    var decodeddata = response.body;
    var data = jsonDecode(decodeddata);
    data.forEach((element) {
      companies.add(Company.fromJson(element));
      hoverEdit.add(false);
      hoverDelete.add(false);
    });

    setState(() {});
  }

  void deleteRecord(int id) {
    client.delete(Uri.parse('http://localhost:8000/api/v1/companies/$id/'));
    _retrieveRecords();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width < 900 ? size.width * 2 : size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: true,
          title: Text(
            'Company Management Dashboard',
            style: TextStyle(
                fontSize: 0.019 * width,
                color: Colors.white,
                fontFamily: 'Satisfy'),
          ),
          flexibleSpace: Container(
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/appbar3.gif'), fit: BoxFit.cover),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
          leading: Icon(
            Icons.supervised_user_circle_rounded,
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
                'Your company, your information!!',
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
                  Text(
                    "Keep your information on your fingertips!!",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 0.012 * width,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewCompany(client)));
                      },
                      child: Center(
                        child: Text(
                          'Add Company +',
                          style: TextStyle(
                              color: Colors.white, fontSize: 0.012 * width),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
                          elevation: MaterialStateProperty.all(5),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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
                        'Company Name',
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
                            _retrieveRecords();
                          },
                          child: companies.length != 0
                              ? ListView.builder(
                                  itemCount: companies.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EmployeeDashboard(
                                                            companies[index]
                                                                .company_id,
                                                            client)));
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          tileColor: Colors.blueAccent
                                              .withOpacity(0.1),
                                          leading: Text('${index + 1}'),
                                          title: Text(
                                            companies[index].name +
                                                " - " +
                                                companies[index].about,
                                            style: TextStyle(
                                                fontSize: 0.012 * width,
                                                color: Colors.black),
                                          ),
                                          subtitle: Text(
                                              companies[index].location,
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
                                                              UpdateCompany(
                                                            client,
                                                            companies[index]
                                                                .company_id,
                                                            companies[index]
                                                                .name,
                                                            companies[index]
                                                                .location,
                                                            companies[index]
                                                                .about,
                                                            companies[index]
                                                                .type,
                                                          ),
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
                                                    deleteRecord(
                                                        companies[index]
                                                            .company_id);
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
                                      'Currenty there is no data\n'
                                      'Please click on add company to add data !!',
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
      ),
    );
  }
}
