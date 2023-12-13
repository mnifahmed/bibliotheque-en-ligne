import 'package:Bibliotheque/models/book.dart';
import 'package:Bibliotheque/models/notifiers/book_notifier.dart';
import 'package:Bibliotheque/widgets/buttons/confirm_button.dart';
import 'package:Bibliotheque/widgets/inputs/book_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'book_details.dart';
final firestore = FirebaseFirestore.instance;
class BookAdd extends StatelessWidget {
  final Book? book;

  const BookAdd({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book == null ? 'Ajouter un livre' : 'Mettre à jour le livre'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: AddBookForm(book: book),
        ),
      ),
    );
  }
}

class AddBookForm extends StatefulWidget {
  final Book? book;

  const AddBookForm({super.key, required this.book});

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  var _title = '';
  var _author = '';
  var _description = '';
  var _rating;
  var _coverUrl = '';
  var _category = '';

  @override
  void initState() {
    super.initState();
    _id = widget.book?.id ?? firestore.collection('books').doc().id;
    _rating = widget.book?.rating;
  }

  @override
  Widget build(BuildContext context) {
    var bookNotifier = Provider.of<BookNotifier>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BookTextFormField(
            labelText: 'Titre',
            errorText: 'Entrez un titre de livre',
            initialValue: widget.book?.title ?? '',
            onSaved: (String? value) => _title = value ?? '',
          ),
          BookTextFormField(
            labelText: 'Auteur',
            errorText: 'Entrez un auteur',
            onSaved: (String? value) => _author = value ?? '',
            initialValue: widget.book?.author ?? '',
          ),
          BookTextFormField(
            labelText: 'Description',
            errorText: 'Entrez une description',
            initialValue: widget.book?.description ?? '',
            onSaved: (String? value) => _description = value ?? '',
          ),
          BookTextFormField(
            labelText: 'URL de cover',
            errorText: 'Entrez une URL de cover',
            initialValue: widget.book?.coverUrl ?? '',
            onSaved: (String? value) => _coverUrl = value ?? '',
          ),
          BookTextFormField(
            labelText: 'Catégorie',
            errorText: 'Entrez une catégorie',
            initialValue: widget.book?.category ?? '',
            onSaved: (String? value) => _category = value ?? '',
          ),
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Avis',
              labelStyle: const TextStyle(color: Colors.grey),
              suffixIcon: Chip(
                label: Text(
                  _rating?.toStringAsFixed(1) ?? 'N/A',
                  style: const TextStyle(color: Colors.black), // Adjust the text color as needed
                ),
                backgroundColor: Colors.grey.withOpacity(0.3), // Adjust the background color as needed
              ),
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.0,
                overlayColor: Colors.grey.withOpacity(0.4),
                thumbColor: Colors.grey,
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.5),
              ),
              child: Slider(
                value: _rating?.roundToDouble() ?? 0.0,
                min: 0.0,
                max: 10.0,
                divisions: 10,
                onChanged: (value) => setState(() => _rating = value),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: ConfirmButton(
              text: widget.book == null ? 'Ajouter un livre' : 'Mettre à jour le livre',
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  final book = Book(
                    _id,
                    _title,
                    _author,
                    _description,
                    _coverUrl,
                    _category,
                    _rating,
                  );

                  bookNotifier.updateBook(widget.book, book);

                  // Pop current route (details screen)
                  Navigator.of(context).pop();

                  // Push a new route with the updated book details
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => BookDetails(book, key: UniqueKey()),
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
