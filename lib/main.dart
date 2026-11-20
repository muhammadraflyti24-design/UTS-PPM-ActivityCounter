import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(const IbadahCounterApp());
}

class IbadahCounterApp extends StatelessWidget {
  const IbadahCounterApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivityViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ibadah Counter',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D28D9)),
          scaffoldBackgroundColor: const Color(0xFFF5F3FF),
        ),
        home: const HomeView(),
      ),
    );
  }
}
