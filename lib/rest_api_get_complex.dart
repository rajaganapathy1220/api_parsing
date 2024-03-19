import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestApiGetComplex extends StatefulWidget {
  const RestApiGetComplex({super.key});

  @override
  State<RestApiGetComplex> createState() => _RestApiGetComplexState();
}

class _RestApiGetComplexState extends State<RestApiGetComplex> {
  List details = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest Api Call Complex'),
      ),
      body: ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(details[index]['name']['first']),
              subtitle: Text(details[index]['email']),
              leading: Text(details[index]['location']['timezone']['offset'])
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getDetails();
        },
      ),
    );
  }

  getDetails() async {
    final response = await rootBundle.loadString('assets/practice.json');
    final data = await json.decode(response);

    setState(() {
      details = data['results'];
      print('$data');
    });
  }
}
