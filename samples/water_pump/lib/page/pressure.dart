import 'package:flutter/material.dart';

class Pressure extends StatelessWidget {
  const Pressure({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: const Color.fromRGBO(0, 0, 0, 0.08),
      padding: const EdgeInsets.fromLTRB(20, 4, 10, 4),
      child: const Text(
        "水压表",
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
