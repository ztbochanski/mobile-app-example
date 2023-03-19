import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/firebase_options.dart';
import 'package:wasteagram/app.dart';
import 'package:wasteagram/services/firestore_service.dart';
import 'package:wasteagram/services/image_picker_service.dart';
import 'package:wasteagram/services/location_service.dart';
import 'package:wasteagram/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirestoreService.initialize();
  await ImagePickerService.initialize();
  await LocationService.initialize();
  await StorageService.initialize();

  runApp(const App());
}
