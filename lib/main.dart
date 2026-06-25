import 'package:flutter/material.dart';
import 'app.dart';
import 'core/widgets/common/map_view_registry.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerMapViewFactory();
  runApp(const App());
}
