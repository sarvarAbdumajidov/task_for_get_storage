

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton(VoidCallback function) {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ],
      ),
    ),
    child: ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Icon(
        CupertinoIcons.arrow_right,
        size: 40,
        color: Colors.white,
      ),
    ),
  );
}