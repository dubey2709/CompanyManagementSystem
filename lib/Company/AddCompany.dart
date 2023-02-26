import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewCompany extends StatefulWidget {
  NewCompany(this.client);
  final Client client;

  @override
  State<NewCompany> createState() => _NewCompanyState();
}

class _NewCompanyState extends State<NewCompany> {
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController about = TextEditingController();
  String _chosenValue = 'IT';
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
              crossAxisAlignment: size.width < 900
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
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
                  'Fill the details of the company',
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
                              hintText: 'Enter Company name'),
                          TextFieldComponent(
                              width: width,
                              controller: location,
                              hintText: 'Enter Office location'),
                        ],
                      )
                    : Column(
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: name,
                              hintText: 'Enter Company name'),
                          SizedBox(height: 0.004 * height),
                          TextFieldComponent(
                              width: width,
                              controller: location,
                              hintText: 'Enter Office location'),
                        ],
                      ),
                SizedBox(height: 0.004 * width),
                MediaQuery.of(context).size.width > 900
                    ? Row(
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: about,
                              hintText: 'Enter something about company'),
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
                                    'IT',
                                    'NON-IT',
                                    'Mobile Phones'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Please choose type of company",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldComponent(
                              width: width,
                              controller: about,
                              hintText: 'Enter something about company'),
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
                                      'IT',
                                      'NON-IT',
                                      'Mobile Phones'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Please choose type of company",
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
                      widget.client.post(
                        Uri.parse('http://127.0.0.1:8000/api/v1/companies/'),
                        body: {
                          'name': name.text,
                          'location': location.text,
                          'about': about.text,
                          'type': _chosenValue,
                          'added_date': "${DateTime.now()}",
                          'active': "${true}"
                        },
                      );
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

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {Key? key,
      required this.width,
      required this.controller,
      required this.hintText})
      : super(key: key);

  final double width;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        width: width * 0.47,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 0.012 * width),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.pinkAccent,
                width: 2.0,
              ),
            ),
          ),
          autofocus: true,
          style: TextStyle(fontSize: 0.012 * width, color: Colors.black),
          cursorColor: Colors.black,
        ),
      ),
    );
  }
}
