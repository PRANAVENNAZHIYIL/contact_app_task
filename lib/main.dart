import 'package:flutter/material.dart';
import 'package:houzeo_app/data/local_data_base.dart';
import 'package:houzeo_app/data/providers.dart';
import 'package:houzeo_app/routes/routes.dart';
import 'package:houzeo_app/theme/themes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HouzeoLocalDBFunctions().openHouzeoLocalDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, oienetation, screenType) {
      return MultiProvider(
        providers: HouzeoProviders().getAllProviders(context),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Houzeo',
            theme: HouzeoAppTheme().getThemeData,
            initialRoute: '/',
            onGenerateRoute: generateRoute,
          );
        },
      );
    });
  }
}
