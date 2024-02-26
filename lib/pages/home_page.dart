import 'package:flutter/material.dart';
import 'package:flutter_shop/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class _HomePageState extends State<HomePage> {
  final CollectionReference vendorsCollection =
      FirebaseFirestore.instance.collection('vendors');

  String dropdownValue1 = 'Dropdown ';
  String dropdownValue2 = 'Dropdown  ';
  String dropdownValue3 = 'Dropdown';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Subhash\'s Stationery',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 64),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Particulars',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 80),
                    Text(
                      'Inventory',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildText('Pen'),
                  SizedBox(width: 30),
                  buildDropdown(
                      dropdownValue1, ['Dropdown ', 'High', 'Medium', 'Low'],
                      (newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                      updateFirestore('Pen', newValue);
                    });
                  }),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildText('Pencil'),
                  SizedBox(width: 10),
                  buildDropdown(
                      dropdownValue2, ['Dropdown  ', 'High', 'Medium', 'Low'],
                      (newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                      updateFirestore('Pencil', newValue);
                    });
                  }),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildText('Books'),
                  SizedBox(width: 10),
                  buildDropdown(
                      dropdownValue3, ['Dropdown', 'High', 'Medium', 'Low'],
                      (newValue) {
                    setState(() {
                      dropdownValue3 = newValue!;
                      updateFirestore('Books', newValue);
                    });
                  }),
                ],
              ),
              SizedBox(height: 30),
              Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(MyRoutes.loginRoute),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
          String value, List<String> items, Function(String?) onChanged) =>
      DropdownButton<String>(
        value: value,
        items: items
            .map((String item) =>
                DropdownMenuItem<String>(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      );

  Widget buildText(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      );

  Future<void> updateFirestore(String fieldName, String value) async {
    try {
      await vendorsCollection.doc('1').update({fieldName: value});
      print('Firestore updated successfully');
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }
}
