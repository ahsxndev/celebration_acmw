import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';
import 'widgets/main_layout.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/speakers_page.dart';
import 'pages/schedule_page.dart';
import 'pages/organizers_page.dart';
import 'pages/contact_page.dart';
import 'pages/registration_page.dart';

void main() {
  // Use path-based URLs (removes the '#' from web URLs)
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define the navigation logic
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      // We wrap every route in the MainLayout so the Navbar and Footer stay visible
      ShellRoute(
        builder: (context, state, child) {
          // Determine the active page based on the current path for the navbar underline
          String active = 'Home';
          if (state.fullPath == '/about') active = 'About';
          if (state.fullPath == '/speakers') active = 'Speakers';
          if (state.fullPath == '/schedule') active = 'Schedule';
          if (state.fullPath == '/registration') active = 'Registration';
          if (state.fullPath == '/organizers') active = 'Organizers';
          if (state.fullPath == '/contact') active = 'Contact';

          return MainLayout(activePage: active, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/about',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AboutPage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/speakers',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SpeakersPage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/schedule',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SchedulePage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/registration',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const RegistrationPage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/organizers',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const OrganizersPage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/contact',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ContactPage(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ACM-W RCET Celebration',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: true),
      routerConfig: _router, // Use the router configuration
    );
  }
}
