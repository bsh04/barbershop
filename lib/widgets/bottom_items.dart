import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Главная', Icons.home, Colors.indigo),
  Destination('Галерея', Icons.photo_library_outlined, Colors.blue),
  Destination('Магазн', Icons.shop_two, Colors.lightBlue),
  Destination('Вызов', Icons.phone, Colors.cyan)
];