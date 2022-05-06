import 'package:flutter/material.dart';


Widget button(context, String buttnText, Color color, Widget widget) {

  return  Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Center(child: widget),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color
            ),
          );
}