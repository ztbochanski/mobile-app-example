import 'dart:io';

import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {
  static LocationData? _locationData;
  static Location location = Location();

  // Singleton pattern
  static late LocationService _instance;

  LocationService._() {
    _instance = this;
  }

  factory LocationService.getInstance() {
    return _instance;
  }

  static Future<void> initialize() async {
    _instance = LocationService._();
  }

  // Get the location asynchronously
  static Future<LocationData?> getLocation() async {
    try {
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          stderr.writeln('Failed to enable location service');
          return null;
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          stderr.writeln('Location service permission not granted');
          return null;
        }
      }
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('PlatformException: $e');
      _locationData = null;
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
}
