import 'package:flutter/material.dart';

class AssetsHelper {

  static String getSVGIcon(String name) {
    return "assets/icons/$name";
  }

  static AssetImage getIcon(String name) {
    return AssetImage("assets/icons/$name");
  }

  static AssetImage getImage(String name) {
    return AssetImage("assets/images/$name");
  }

  static AssetImage getLogo(String name) {
    return AssetImage("assets/logo/$name");
  }
}