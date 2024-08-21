import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';
import 'map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child: MaterialApp(
        title: 'Mapa de Distancia',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MapScreen(),
      ),
    );
  }
}
