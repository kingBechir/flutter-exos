import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color.fromARGB(255, 173, 187, 210),
      brightness: dark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exo 1',
      theme: theme,
      home: ExoOnePage(
        onToggleTheme: () => setState(() => dark = !dark),
      ),
    );
  }
}

class ExoOnePage extends StatelessWidget {
  const ExoOnePage({super.key, required this.onToggleTheme});
  final VoidCallback onToggleTheme;

  static const Color appBarColor = Color.fromARGB(255, 69, 95, 136);
  static const Color boxColor = Color.fromARGB(255, 54, 127, 244);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text('Exo 1'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Hello Bechir👋')),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Basculer thème',
            onPressed: onToggleTheme,
          ),
        ],
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFFCF7FB),

      body: LayoutBuilder(
        builder: (context, c) {
          final size = math.min(c.maxWidth, c.maxHeight) * 0.3;
          return Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(size * 0.1),
              ),
            ),
          );
        },
      ),
    );
  }
}
