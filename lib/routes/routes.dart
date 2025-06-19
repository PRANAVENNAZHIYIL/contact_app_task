import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/provider/add_edit_contact_provider.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/screen/call_or_edit_screen.dart';
import 'package:houzeo_app/presentation/features/contact_list/provider/view_contact_list_provider.dart';
import 'package:houzeo_app/presentation/features/contact_list/screen/contact_list_page.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/provider/view_contact_profile_provider.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/screen/view_contact_screen.dart';
import 'package:houzeo_app/presentation/features/dial_pad/provider/dial_pad_provider.dart';
import 'package:houzeo_app/presentation/features/dial_pad/screen/dial_pad_screen.dart';
import 'package:houzeo_app/presentation/features/main_screen/provider/main_screen_provider.dart';
import 'package:houzeo_app/presentation/features/main_screen/screen/main_screen.dart';
import 'package:houzeo_app/routes/nav_params.dart';
import 'package:houzeo_app/routes/profile_nav_params.dart';
import 'package:provider/provider.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (_) => MainScreenController(),
          child: MainScreen(),
        ),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      );

    case '/AddEditScreen':
      final args = settings.arguments as AddEditNavParams;

      return PageRouteBuilder(
        pageBuilder: (c, __, ___) => ChangeNotifierProvider(
          create: (_) => AddEditProvider()..setInitialArgs(c, args),
          child: const AddOrEditContactScreen(),
        ),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      );

    case '/contactListScreen':
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (_) => ViewContactsScreenController(),
          child: const ViewContactsScreen(),
        ),
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnim = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.ease));
          return SlideTransition(position: offsetAnim, child: child);
        },
      );

    case '/contactProfileScreen':
      final args = settings.arguments as ProfileNavParams;

      return PageRouteBuilder(
        pageBuilder: (c, __, ___) => ChangeNotifierProvider(
          create: (_) =>
              ViewContactProfileScreenController()..setInitialArgs(c, args),
          child: const ViewContactProfileScreen(),
        ),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(1, 0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      );

    case '/DialScreen':
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (_) => DialPadScreenController(),
          child: const DialPadScreen(),
        ),
        transitionsBuilder: (_, animation, __, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
          final fade = Tween<double>(begin: 0, end: 1).animate(animation);
          return SlideTransition(
            position: slide,
            child: FadeTransition(opacity: fade, child: child),
          );
        },
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
