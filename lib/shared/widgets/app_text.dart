import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

enum AppTextType {
  normal,
  html,
  autosize,
}

final class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    this.type = AppTextType.normal,
    this.maxLines,
    this.style,
    this.htmlStiles,
    super.key,
  });

  final String text;
  final AppTextType type;
  final int? maxLines;
  final TextStyle? style;
  final Map<String, Style>? htmlStiles;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AppTextType.normal => Text(
          text,
          maxLines: maxLines,
          style: style,
        ),
      AppTextType.html => Html(
          data: text,
          style: htmlStiles ?? {},
        ),
      AppTextType.autosize => AutoSizeText(
          text,
          maxLines: maxLines,
          style: style,
        ),
    };
  }
}
