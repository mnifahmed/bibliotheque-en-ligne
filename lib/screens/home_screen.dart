import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Bibliotheque/models/book.dart';
import 'package:Bibliotheque/screens/book/book_details.dart';
import 'package:Bibliotheque/models/notifiers/book_notifier.dart';
import 'package:Bibliotheque/models/notifiers/theme_notifier.dart';
import 'package:Bibliotheque/screens/book/book_add.dart';
import 'package:Bibliotheque/widgets/book_list.dart';
import 'package:Bibliotheque/style.dart';
import 'package:Bibliotheque/screens/login_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);
    var bookNotifier = Provider.of<BookNotifier>(context);
    List<Book> books = bookNotifier.books;

    return Scaffold(
      appBar: _buildAppBar(context, themeNotifier),
      drawer: _buildDrawer(context),
      body: Container(
        child: MediaQuery.of(context).size.width > wideLayoutThreshold
            ? Row(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: BookList(books: books),
            ),
            Flexible(
              flex: 6,
              child: BookDetails(bookNotifier.books[bookNotifier.selectedIndex]),
            ),
          ],
        )
            : BookList(books: books),
      ),
      floatingActionButton: MediaQuery.of(context).size.width < wideLayoutThreshold
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const BookAdd(book: null)));
        },
      )
          : Container(),
    );
  }

  AppBar _buildAppBar(BuildContext context, ThemeNotifier themeNotifier) {
    return AppBar(
      title: const Text('Bibliothèque de livres'),
      actions: [
        IconButton(
          icon: themeNotifier.themeMode == ThemeMode.dark
              ? const Icon(Icons.brightness_7)
              : const Icon(Icons.brightness_2),
          color: Theme.of(context).iconTheme.color,
          onPressed: () => themeNotifier.toggleTheme(),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: BookSearch());
          },
        ),
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ), child: null,
          ),
          ListTile(
            title: Text('Déconnexion'),
            leading: Icon(Icons.logout),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.5, // Adjust the width as needed
    );
  }
}

class BookSearch extends SearchDelegate<Book> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        color: Theme.of(context).iconTheme.color,
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Theme.of(context).iconTheme.color,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final books = Provider.of<BookNotifier>(context).books;

    final results = books
        .where((book) =>
        book.title.toLowerCase().contains(query) ||
        book.author.toLowerCase().contains(query))
        .toList();

    return BookList(books: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final books = Provider.of<BookNotifier>(context).books;

    final results = books
        .where((book) =>
        book.title.toLowerCase().contains(query) ||
        book.author.toLowerCase().contains(query))
        .toList();

    return BookList(books: results);
  }
}
