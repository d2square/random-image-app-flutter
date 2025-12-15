import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:random_image_app/screens/image_screen/presentation/bloc/image_bloc.dart';
import 'package:random_image_app/screens/image_screen/presentation/pages/image_screen.dart';
import 'core/di/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const RandomImageApp());
}
class RandomImageApp extends StatelessWidget {
  const RandomImageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Image',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => di.sl<ImageBloc>(),
        child: const ImageScreen(),
      ),
    );
  }
}