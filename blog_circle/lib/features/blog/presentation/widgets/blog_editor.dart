import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class BlogEditor extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const BlogEditor({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
      controller: controller,
    );
  }
}
