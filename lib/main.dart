import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app.dart';
import 'core/widgets/common/map_view_registry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerMapViewFactory();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
