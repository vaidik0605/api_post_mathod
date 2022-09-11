import 'package:api_post_mathod/view_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class insert_page extends StatefulWidget {
  const insert_page({Key? key}) : super(key: key);

  @override
  State<insert_page> createState() => _insert_pageState();
}

class _insert_pageState extends State<insert_page> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontect = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: tname,
          ),
          TextField(
            controller: tcontect,
          ),
          ElevatedButton(
              onPressed: () async {
                String name = tname.text;
                String contect = tcontect.text;
                Map m = {'id': '10', 'name': name, 'contect': contect};

                var url = Uri.parse(
                    'https://cdmidevelopment.000webhostapp.com/9to10/insert.php');
                var response = await http.post(url, body: m);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return view_page();
                  },
                ));

                // Map map = {'name': name, 'contact': contect};
                // var url = Uri.parse(
                //     'https://cdmidevelopment.000webhostapp.com/9to10/insert.php');
                // var response = await http.post(url, body: map);
                // print('Response status: ${response.statusCode}');
                // print(response.body);
              },
              child: const Text("Submit"))
        ],
      ),
    );
  }
}
