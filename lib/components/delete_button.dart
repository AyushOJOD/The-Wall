import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? ontap;
  const DeleteButton({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: const Icon(Icons.cancel),
    );
  }
}
