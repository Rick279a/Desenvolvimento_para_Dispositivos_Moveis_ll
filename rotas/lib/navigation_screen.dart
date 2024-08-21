import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';
import 'package:geolocator/geolocator.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navegação')),
      body: Consumer<LocationProvider>(
        builder: (context, provider, child) {
          double distance1 =
              calculateDistance(provider.currentLocation!, provider.waypoint1!);
          double distance2 =
              calculateDistance(provider.waypoint1!, provider.waypoint2!);
          double totalDistance = distance1 + distance2;

          return Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      (provider.currentLocation!.latitude +
                              provider.waypoint2!.latitude) /
                          2,
                      (provider.currentLocation!.longitude +
                              provider.waypoint2!.longitude) /
                          2,
                    ),
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: provider.currentLocation!,
                          builder: (ctx) =>
                              Icon(Icons.my_location, color: Colors.blue),
                        ),
                        Marker(
                          point: provider.waypoint1!,
                          builder: (ctx) =>
                              Icon(Icons.location_on, color: Colors.green),
                        ),
                        Marker(
                          point: provider.waypoint2!,
                          builder: (ctx) =>
                              Icon(Icons.location_on, color: Colors.red),
                        ),
                      ],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [
                            provider.currentLocation!,
                            provider.waypoint1!,
                            provider.waypoint2!
                          ],
                          color: Colors.blue,
                          strokeWidth: 5.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        'Distância Total: ${(totalDistance / 1000).toStringAsFixed(2)} km'),
                    Text('Tempo estimado: ${estimatedTime(totalDistance)}'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  String estimatedTime(double distance) {
    double timeInHours = distance / 60000;
    return "${(timeInHours * 60).toStringAsFixed(1)} minutos";
  }
}
