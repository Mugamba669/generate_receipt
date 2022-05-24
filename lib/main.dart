import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generate_rec/Db/receipt.dart';
import 'package:generate_rec/Db/record.dart';
import 'package:hive_flutter/adapters.dart';

import 'Global/globals.dart';

/// routes' urls
import 'pages/newreceipt.dart';
import 'pages/dashboard.dart';
import 'pages/Splash.dart';
import 'pages/debtors.dart';
import 'pages/saved.dart';
import 'pages/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  await Hive.initFlutter();
  Hive.registerAdapter<Receipt>(ReceiptAdapter());
  Hive.registerAdapter<Record>(RecordAdapter());
  await Hive.openBox<Receipt>(boxName);
  await Hive.openBox<Record>(records);
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receipt Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[200]),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/dashboard': (context) => const Dashboard(),
        '/savedreceipts': (context) => const SavedReceipts(),
        '/debtors': (context) =>  Debtors(),
        '/search': (context) => const Search()
      },
    );
  }
}
