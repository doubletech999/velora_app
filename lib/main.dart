import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/localization/language_provider.dart';
import 'presentation/providers/paths_provider.dart';
import 'presentation/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => PathsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const VeloraApp(),
    ),
  );
}