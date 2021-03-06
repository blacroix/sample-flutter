import 'package:flutter/material.dart';

class WidgetLoading extends StatelessWidget {
  const WidgetLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}
