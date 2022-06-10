import 'package:flutter/material.dart';

class CounterComponent extends StatelessWidget {
  const CounterComponent({
    required this.count,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final int count;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 6,),
        Text(count.toString()),
      ],
    );
  }
}
