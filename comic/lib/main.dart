import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/app.dart';
import 'screens/dashboard/dash_board_provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DashBoardContestProvider()),
  ], child: const MyApp()));
}
