import 'package:Bibliotheque/models/notifiers/theme_notifier.dart';
import 'package:Bibliotheque/screens/book/book_add.dart';
import 'package:Bibliotheque/style.dart';
import 'package:Bibliotheque/theme/colors.dart';
import 'package:Bibliotheque/widgets/book_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:Bibliotheque/models/book.dart';
import 'package:Bibliotheque/models/notifiers/book_notifier.dart';
import 'package:Bibliotheque/widgets/star_rating.dart';

class BookDetails extends StatelessWidget {
  final Book _book;

  const BookDetails(Book book, {super.key}) : _book = book;

  @override
  Widget build(BuildContext context) {
    var bookNotifier = Provider.of<BookNotifier>(context);
    var themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: MediaQuery.of(context).size.width < wideLayoutThreshold
          ? _buildAppBar(context)
          : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: BookCover(
                  url: _book.coverUrl,
                  boxFit: BoxFit.fitHeight,
                  height: 325,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 4.0),
                child: Text(
                  _book.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Par ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      TextSpan(
                        text: _book.author,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      TextSpan(
                        text: ' dans ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: _book.category,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              StarRating(
                starCount: 5,
                rating: (_book.rating / 2).toDouble(),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.5),
                height: 38.0,
              ),
              Text(
                _book.description,
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withOpacity(0.85),
                    fontFamily: 'Nunito',
                    fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MediaQuery.of(context).size.width >
              wideLayoutThreshold
          ? SpeedDial(
              overlayOpacity: 0.25,
              overlayColor:
                  themeNotifier.isDarkModeEnabled ? Colors.black : Colors.white,
              animatedIcon: AnimatedIcons.home_menu,
              children: [
                _buildSubFab('Remove', Icons.delete,
                    () => _showDeleteDialog(context, bookNotifier)),
                _buildSubFab(
                    'Edit',
                    Icons.edit,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BookAdd(book: _book)))),
                _buildSubFab(
                    'Add',
                    Icons.add,
                    () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => BookAdd(book: _book))))
              ],
            )
          : FloatingActionButton(
              child: const Icon(Icons.delete),
              onPressed: () => _showDeleteDialog(context, bookNotifier),
            ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Détails'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.edit,
            size: 22.0,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BookAdd(book: _book),
              ),
            );
          },
        ),
      ],
    );
  }

  SpeedDialChild _buildSubFab(String label, IconData iconData, void Function() onTap) {
    return SpeedDialChild(
      label: label,
      labelStyle: const TextStyle(color: kTextTitleColor),
      child: Icon(iconData),
      onTap: onTap,
    );
  }

  void _showDeleteDialog(
      BuildContext context, BookNotifier bookNotifier) async {
    final dialog = AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Supprimer le livre ?', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),),
      content: Text(
        'Cela supprimera le livre de votre liste de livres',
        style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
      ),
      actions: [
        TextButton(
          child: Text(
            'ANNULER',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(
            'ACCEPTER',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          onPressed: () {
            bookNotifier.removeBook(_book);
            // Pop details screen
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    await showDialog(context: context, builder: (context) => dialog);
  }
}
