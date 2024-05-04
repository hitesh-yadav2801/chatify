import 'package:chatify/core/theme/style.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(tabColor),
        strokeWidth: 2,
        backgroundColor: Colors.white,
      ),
    );
  }
}
