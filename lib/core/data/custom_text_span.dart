import 'package:flutter/material.dart';

class CustomTextSpan extends TextSpan {
  final bool isTag;
  const CustomTextSpan({
    super.style,
    required String super.text,
    required this.isTag,
  });
}
