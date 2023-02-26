import 'package:flutter/material.dart';
import '../Company/AddCompany.dart';
import 'package:http/http.dart';

class UpdateEmployee extends StatefulWidget {
  UpdateEmployee(this.client, this.id, this.name, this.email, this.address,
      this.about, this.phone, this.position, this.company_id);
  final Client client;
  final int id;
  final String name;
  final String email;
  final String address;
  final String about;
  final String phone;
  final String position;
  final int company_id;

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController phone = TextEditingController();
  late String position;

  @override
  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    phone.text = widget.phone;
    address.text = widget.address;
    about.text = widget.about;
    position = widget.position;
    // TODO: implement initState
    super.initState();
  }

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
                  height: 0.5 * height,
                  child: Image(
                    image: AssetImage('assets/company.gif'),
                  ),
                ),
                SizedBox(height: 0.010 * height),
                Text(
                  'Update the details of the Employee',
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
                SizedBox(height: 0.008 * width),
                MediaQuery.of(context).size.width > 900
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: address,
                              hintText: 'Enter address of Employee'),
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
                              hintText: 'Enter address of Employee'),
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
                              hintText: 'Enter phone No of Employee'),
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
                                  value: position,
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
                                    "Please enter position of Employee",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      position = value!;
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
                                    value: position,
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
                                      "Please position of Employee",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        position = value!;
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
                      widget.client.put(
                        Uri.parse(
                            'http://127.0.0.1:8000/api/v1/employees/${widget.id}/'),
                        body: {
                          'name': name.text,
                          'email': email.text,
                          'address': address.text,
                          'about': about.text,
                          'phone': phone.text,
                          'position': position,
                          'company':
                              "http://127.0.0.1:8000/api/v1/companies/${widget.company_id}/"
                        },
                      );
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Update',
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
