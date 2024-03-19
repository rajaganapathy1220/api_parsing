import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestApiGetOne extends StatefulWidget {
  const RestApiGetOne({super.key});

  @override
  State<RestApiGetOne> createState() => _RestApiGetOneState();
}

class _RestApiGetOneState extends State<RestApiGetOne> {
  List _details = [];
  var text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest API Call'),
      ),
      body: ListView.builder(
          itemCount: _details.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                subtitle: Text(_details[index]['Lane']),
                leading: Text(_details[index]['House No']),
                title: Text(text['name']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getDetails();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  getDetails() async {
    final response = await rootBundle.loadString('assets/details_one.json');
    final data = await json.decode(response);

    print('data recieved:${data}');

    setState(() {
      _details = data['Address'];
      text = data;
    });
  }
}
