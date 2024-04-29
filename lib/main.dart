import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:cron/presentation/blocs/activity_bloc.dart';
import 'package:cron/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => ActivityBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Template',
        theme: _buildTheme(Brightness.dark),
        home: const MainScreen(),
      ),
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  var baseTheme = ThemeData(
      brightness: brightness,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color.fromARGB(255, 171, 171, 171),
        linearTrackColor: Color.fromARGB(255, 0, 57, 13),
      ));

  return baseTheme.copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color.fromARGB(255, 53, 85, 62)),
  );
}
