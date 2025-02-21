import 'package:flutter/material.dart';

class CustomTextController extends TextEditingController {
  final Map<String, TextStyle> formattingRules;

  CustomTextController({required this.formattingRules, String? text})
      : super(text: text);

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<InlineSpan> children = [];
    final RegExp regExp =
        RegExp(r'\[\[(.*?)\]\](.*?)\[\[\/\1\]\]', multiLine: true);

    String text = this.text;
    int lastIndex = 0;

    for (final Match m in regExp.allMatches(text)) {
      if (m.start > lastIndex) {
        children.add(TextSpan(
          text: text.substring(lastIndex, m.start),
          style: style,
        ));
      }

      String formatType = m.group(1)!;
      String content = m.group(2)!;

      TextStyle? customStyle = formattingRules[formatType] ?? style;

      children.add(TextSpan(
        text: content,
        style: customStyle,
      ));

      lastIndex = m.end;
    }

    if (lastIndex < text.length) {
      children.add(TextSpan(
        text: text.substring(lastIndex),
        style: style,
      ));
    }

    return TextSpan(children: children, style: style);
  }
}
