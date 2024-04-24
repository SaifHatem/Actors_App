import 'package:breakingbad/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ActorsApp(appRouter: AppRouter()));
}

class ActorsApp extends StatelessWidget {
  const ActorsApp({super.key, required this.appRouter});

  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
