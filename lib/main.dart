import 'package:Bibliotheque/models/notifiers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Bibliotheque/models/notifiers/book_notifier.dart';
import 'package:Bibliotheque/screens/splash_screen.dart';
import 'package:Bibliotheque/theme/theme.dart' as libraryTheme;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'models/book.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final bookNotifier = BookNotifier();
  await bookNotifier.fetchBooks();
  runApp(BookLibrary());
}

class BookLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeNotifier();
    final bookNotifier = BookNotifier();
    final firestore = FirebaseFirestore.instance;

    Future<List<Book>> fetchBooks() async {
      final snapshot = await firestore.collection('books').get();
      return snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList();
    }

    final Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
    themeNotifier.themeMode = systemBrightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeNotifier),
        ChangeNotifierProvider(create: (_) => bookNotifier),
      ],
      child: Builder(
        builder: (context) {
          final themeNotifier = Provider.of<ThemeNotifier>(context);
          return MaterialApp(
            title: 'Book Library',
            themeMode: themeNotifier.themeMode,
            darkTheme: libraryTheme.Theme.darkTheme,
            theme: libraryTheme.Theme.lightTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
