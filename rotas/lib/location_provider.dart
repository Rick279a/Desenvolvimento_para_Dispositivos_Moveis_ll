import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider extends ChangeNotifier {
  LatLng? currentLocation;
  LatLng? waypoint1;
  LatLng? waypoint2;

  LocationProvider() {
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showError('Permissão de localização foi negada');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showError('Permissão de localização foi negada permanentemente');
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    } catch (e) {
      _showError('Erro ao obter a localização');
    }
  }

  void setWaypoint(LatLng point) {
    if (waypoint1 == null) {
      waypoint1 = point;
    } else if (waypoint2 == null) {
      waypoint2 = point;
    }
    notifyListeners();
  }

  void clearRoute() {
    waypoint1 = null;
    waypoint2 = null;
    notifyListeners();
  }

  void _showError(String message) {
    print(message);
  }
}
