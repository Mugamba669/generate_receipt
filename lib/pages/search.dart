// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:generate_rec/models/DashModel.dart';

import '../Db/receipt.dart';
import '../widgets/Body.dart';
import '../widgets/form_input.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List receipt = List<Receipt>.empty(growable: true);
  String results = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 6.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [],
                  ),
                ),
              ),
            ),
            Positioned(
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          // radius: 30,
                          backgroundColor: Colors.white,
                          child: BackButton()),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: FormInput(
                          hint: "Type here to search...",
                          prefixIcon: Icons.search,
                          inputAction: TextInputAction.search,
                          input: (value) {
                            setState(() {
                              results = (value.toString());
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
