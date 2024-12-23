import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.style,
    required this.child,
    this.onPressed,
  });
  final ButtonStyle style;
  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: child,
    );
  }
}
