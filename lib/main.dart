import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:n3ds_taller/app.dart';
import 'package:n3ds_taller/core/config/app_env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: AppEnv.projectURL,
    publishableKey: AppEnv.publishableKey,
  );

  runApp(const App());
}
