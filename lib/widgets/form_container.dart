import 'package:flutter/material.dart';



class FormContainer extends StatelessWidget {
  const FormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(width: 1, color: Color(0xff94A3B8),),borderRadius: BorderRadius.circular(1)),

    );
  }
}
