import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/add_notes.dart';
import 'views/home_screen.dart';
import 'views/login_screen.dart';
import 'views/registration_screen.dart';
import 'views/splash_screen.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/addNote',
      builder: (context, state) => AddNotesScreen(),
    ),
  ],

  redirect: (BuildContext context, GoRouterState state) {
    final bool isLoggedIn = _firebaseAuth.currentUser != null;
    final bool isLoggingIn = state.matchedLocation == '/login';
    final bool isRegistering = state.matchedLocation == '/register';
    final bool isSplash = state.matchedLocation == '/';

    if (isSplash) {
      return null;
    }

    if (!isLoggedIn && !isLoggingIn && !isRegistering) {
      return '/login';
    }

    if (isLoggedIn && (isLoggingIn || isRegistering)) {
      return '/home';
    }

    return null;
  },
);