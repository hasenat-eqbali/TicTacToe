import 'package:flutter/material.dart';

class GameButtons {
  final id;
  String text;
  Color bg;
  bool enabaled; 

  GameButtons({this.id, this.text="", this.bg = Colors.grey, this.enabaled=true});
}