import 'package:easy_2_clip/providers/video_file_controller.dart';
import 'package:easy_2_clip/screens/clip_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VideoFileController(),
        )
      ],
      child: MaterialApp(
        title: 'Easy2Clip',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(0, 72, 61, 139),
          ),
          useMaterial3: true,
        ),
        home: const ClipScreen(),
      ),
    );
  }
}
