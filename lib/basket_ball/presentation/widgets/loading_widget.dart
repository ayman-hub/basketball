import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

Widget loading() {
  return Center(
      child: JumpingText(
        'Loading',
        style: TextStyle(color: Colors.red, fontSize: 20),
      ));}