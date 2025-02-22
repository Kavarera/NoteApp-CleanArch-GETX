import 'package:flutter/material.dart';

class CustomTextSpan extends TextSpan {
  final bool isTag;
  const CustomTextSpan({
    TextStyle? style,
    required String text,
    required this.isTag,
  }) : super(
          style: style,
          text: text,
        );
}
