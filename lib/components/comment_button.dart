import 'package:flutter/material.dart';

class CommmentButton extends StatelessWidget {
  final void Function()? ontap;
  const CommmentButton({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: const Icon(Icons.comment),
    );
  }
}
