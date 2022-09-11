import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'insert_page.dart';

class view_page extends StatefulWidget {
  const view_page({Key? key}) : super(key: key);

  @override
  State<view_page> createState() => _view_pageState();
}

class _view_pageState extends State<view_page> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  List l = [];
  bool status = false;
  Future<void> loadData() async {
    // Map m = {'id': '15'};

    // var url = Uri.parse(
    //     'https://cdmidevelopment.000webhostapp.com/9to10/viewdata.php');
    // var response = await http.post(url, body: m);
    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    var url = Uri.parse(
        'https://cdmidevelopment.000webhostapp.com/9to10/viewdata.php?id=10');
    var response = await http.post(url);

    Map map = jsonDecode(response.body);

    int result = map['result'];

    if (result == 1) {
      l = map['data'];
    }

    status = true;
    setState(() {});
    print(l);
  }

  int store = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view_page"),
        centerTitle: true,
      ),
      body: (status)
          ? (l.isNotEmpty
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map m = l[index];

                    User user = User.fromJson(m);

                    return ListTile(
                      leading: Text("${user.id}"),
                      title: Text("${user.name}"),
                      subtitle: Text("${user.contact}"),
                      trailing: DropdownButton(
                        value: store,
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text("data"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("data1"),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text("data2"),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text("data3"),
                          ),
                        ],
                        onChanged: (value) {
                          store = value as int;
                          setState(() {});
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("NO DATA FOUND"),
                ))
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insert_page();
            },
          ));
        },
      ),
    );
  }
}

class User {
  String? id;
  String? name;
  String? contact;

  User({this.id, this.name, this.contact});

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    return data;
  }
}
