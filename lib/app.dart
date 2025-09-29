import 'package:flutter/material.dart';

import 'SharedConfig/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,


      home: const Scaffold(
        body: Center(
          child: Text('Welcome to GoFix!'),
        ),
      ),
    );
  }
}
