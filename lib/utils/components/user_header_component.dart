import 'package:flutter/material.dart';

class UserHeaderComponent extends StatelessWidget {
  const UserHeaderComponent({
    required this.username,
    required this.avatar,
    Key? key,
  }) : super(key: key);

  final String username;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: Image.network(avatar).image,
        ),
        const SizedBox(width: 8),
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
