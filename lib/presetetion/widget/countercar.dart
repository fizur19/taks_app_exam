import 'package:flutter/material.dart';

class countercard extends StatelessWidget {
  const countercard({super.key, required this.amount, required this.txt});
  final int amount;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(children: [
          Text(
            '$amount',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            txt,
            style: TextStyle(color: Colors.grey),
          ),
        ]),
      ),
    );
  }
}
