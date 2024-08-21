import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';
import 'navigation_screen.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa de Navegação')),
      body: Consumer<LocationProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) {
                    if (provider.waypoint1 == null ||
                        provider.waypoint2 == null) {
                      provider.setWaypoint(point);
                      if (provider.waypoint2 != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NavigationScreen(),
                          ),
                        );
                      }
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  if (provider.currentLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: provider.currentLocation!,
                          builder: (ctx) =>
                              Icon(Icons.my_location, color: Colors.blue),
                        ),
                        if (provider.waypoint1 != null)
                          Marker(
                            point: provider.waypoint1!,
                            builder: (ctx) =>
                                Icon(Icons.location_on, color: Colors.green),
                          ),
                        if (provider.waypoint2 != null)
                          Marker(
                            point: provider.waypoint2!,
                            builder: (ctx) =>
                                Icon(Icons.location_on, color: Colors.red),
                          ),
                      ],
                    ),
                  if (provider.waypoint1 != null && provider.waypoint2 != null)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [provider.waypoint1!, provider.waypoint2!],
                          color: Colors.blue,
                          strokeWidth: 5.0,
                        ),
                      ],
                    ),
                ],
              ),
              if (provider.currentLocation == null)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LocationProvider>().clearRoute();
        },
        child: Icon(Icons.clear),
        tooltip: 'Limpar Rota',
      ),
    );
  }
}
