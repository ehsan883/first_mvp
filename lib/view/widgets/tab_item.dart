import 'package:flutter/material.dart';

enum TabItem { red, green, blue }

const Map<TabItem, String> tabName = {
  TabItem.red: 'Home',
  TabItem.green: 'Camera',
  TabItem.blue: 'Settings',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};