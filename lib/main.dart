import 'package:flutter/material.dart';
import 'package:graduation/core/helper/supabase_keys.dart';
import 'package:graduation/views/kidguardhomescreen.dart';
import 'package:graduation/views/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseKeys.url,
    anonKey: SupabaseKeys.anonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //create supabase client to save user logged in
    SupabaseClient client = Supabase.instance.client;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: client.auth.currentUser != null
          ? const KidGuardHomeScreen()
          : const WelcomeScreen(),
    );
  }
}
