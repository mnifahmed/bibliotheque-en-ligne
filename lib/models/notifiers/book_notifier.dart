import 'package:Bibliotheque/models/book.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Class used to manage the state in the app
/// Contains all the books that are available
/// and provides methods to manage the state such as
/// addBook, removeBook
class BookNotifier extends ChangeNotifier {
  late List<Book> _books;
  List<Book> get books => _books;
  set books(List<Book> books) {
    _books = books;
    notifyListeners();
  }
  final firestore = FirebaseFirestore.instance;

  Future<void> fetchBooks() async {
    final snapshot = await firestore.collection('books').get();
    _books = snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList();
    notifyListeners();
  }

  late int _selectedIndex;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  BookNotifier() {
    fetchBooks();
    _selectedIndex = 0;
  }

  Future<void> addBook(Book book) async {
    await firestore.collection('books').doc(book.id).set(book.toMap());
    books = (_books..add(book));
    notifyListeners();
  }

  Future<void> removeBook(Book book) async {
    try {
      await firestore.collection('books').doc(book.id).delete();
      books = books.where((b) => b.id != book.id).toList();
    } catch (e) {
      print('Error removing book: $e');
    }
  }

  Future<void> updateBook(Book? oldBook, Book newBook) async {
    try {
      if (oldBook == null) {
        // Handle the case where oldBook is null, e.g., add the new book to the list
        await addBook(newBook);
      } else {
        // Update the book in the Firestore collection using the document ID
        final docRef = firestore.collection('books').doc(oldBook.id);
        await docRef.update(newBook.toMap());

        // Update the local list
        final index = books.indexOf(oldBook);
        books[index] = newBook.copyWith(id: oldBook.id);

        notifyListeners();
      }

      notifyListeners();
    } catch (e) {
      print('Error updating book: $e');
    }
  }

}
