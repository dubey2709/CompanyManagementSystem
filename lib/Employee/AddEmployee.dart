import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Company/AddCompany.dart';

class NewEmployee extends StatefulWidget {
  NewEmployee(this.client, this.cId);
  final Client client;
  final int cId;
  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController about = TextEditingController();
  String _chosenValue = 'Manager';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width < 900 ? size.width * 2 : size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: size.width > 900
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  height: 0.4 * height,
                  child: Image(
                    image: AssetImage('assets/company.gif'),
                  ),
                ),
                SizedBox(height: 0.010 * height),
                Text(
                  'Fill the details of the Employee',
                  style: TextStyle(
                      fontSize: 0.020 * width,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 0.008 * width),
                MediaQuery.of(context).size.width > 900
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: name,
                              hintText: 'Enter Employee name'),
                          TextFieldComponent(
                              width: width,
                              controller: email,
                              hintText: 'Enter Employee email'),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: name,
                              hintText: 'Enter Employee name'),
                          SizedBox(height: 0.004 * height),
                          TextFieldComponent(
                              width: width,
                              controller: email,
                              hintText: 'Enter Employee email'),
                        ],
                      ),
                MediaQuery.of(context).size.width > 900
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: address,
                              hintText: 'Enter Employee address'),
                          TextFieldComponent(
                              width: width,
                              controller: about,
                              hintText: 'Enter some info about Employee'),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: address,
                              hintText: 'Enter Employee address'),
                          SizedBox(height: 0.004 * height),
                          TextFieldComponent(
                              width: width,
                              controller: about,
                              hintText: 'Enter some info about Employee'),
                        ],
                      ),
                SizedBox(height: 0.004 * width),
                MediaQuery.of(context).size.width > 900
                    ? Row(
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: phone,
                              hintText: 'Enter Phone No of Employee'),
                          SizedBox(width: 0.035 * width),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(top: 10),
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DropdownButton<String>(
                                  value: _chosenValue,
                                  elevation: 5,
                                  underline: Container(),
                                  style: TextStyle(color: Colors.black),
                                  items: <String>[
                                    'Manager',
                                    'SoftwareDeveloper',
                                    'ProjectLeader'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Please choose type of position",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _chosenValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: phone,
                              hintText: 'Enter phone No of Employee'),
                          SizedBox(height: 0.004 * height),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(top: 10),
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 0.46 * width,
                                  child: DropdownButton<String>(
                                    value: _chosenValue,
                                    elevation: 5,
                                    underline: Container(),
                                    style: TextStyle(color: Colors.black),
                                    items: <String>[
                                      'Manager',
                                      'SoftwareDeveloper',
                                      'ProjectLeader'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Please choose type of position",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenValue = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 0.030 * height),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        widget.client.post(
                            Uri.parse(
                                'http://127.0.0.1:8000/api/v1/employees/'),
                            body: {
                              'name': name.text,
                              'email': email.text,
                              'address': address.text,
                              'phone': phone.text,
                              'about': about.text,
                              'position': _chosenValue,
                              'company':
                                  "http://127.0.0.1:8000/api/v1/companies/${widget.cId}/"
                            });
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Save',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
