import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 300,
          width: 300,
          child: Image.asset("assets/images/empty-list.gif")),
    );
  }
}
