import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/contants.dart';
import 'data/notifiers.dart';
import 'screens/home.dart';

Future<void> main() async {
  // ① Make sure we can call async APIs before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // ② Load your .env
  await dotenv.load(fileName: ".env");

  // ③ Read the saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final bool isDark = prefs.getBool(KConstants.themeModeKey) ?? false;

  // ④ Store it into your ValueNotifier (so your widgets pick it up instantly)
  isDarkModeNotifier.value = isDark;

  // ⑤ Now we know everything—start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Open Exchange App',
          debugShowCheckedModeBanner: false,

          // ① Define your light & dark themes
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'DMSans',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: 'DMSans',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.dark,
            ),
          ),

          // ② Tell Flutter which one to use
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          home: const Home(),
        );
      },
    );
  }
}
