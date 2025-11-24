import 'package:flutter/material.dart';

class MealsApiButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;

  const MealsApiButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const CircularProgressIndicator()
          : const Text("Search in API"),
    );
  }
}
