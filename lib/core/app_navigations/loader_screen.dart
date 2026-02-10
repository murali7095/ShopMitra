import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(height: 200,width: 200,child: CircularProgressIndicator(),),);
  }
}
