
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String text;
  Color col;
  double? fontsize;
  CustomTextField({super.key , required this.text , required this.col , this.fontsize });

  @override
  Widget build(BuildContext context) {
    return  Text('${text}' , style: TextStyle(
                    fontSize: fontsize ?? 16,
                    color: col
                  ),);
  }
}