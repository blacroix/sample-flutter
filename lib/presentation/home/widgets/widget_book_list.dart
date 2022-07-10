import 'package:flutter/material.dart';
import 'package:sample/app_router.gr.dart';
import 'package:sample/injection.dart';

import '../../../domain/model/book.dart';

class WidgetBookList extends StatelessWidget {
  final List<Book> _books;
  final AppRouter _router = getIt<AppRouter>();

  WidgetBookList(this._books, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: _books.length,
      itemBuilder: (context, index) => ListTile(
            leading: Image.network(_books[index].cover),
            title: Text(_books[index].title),
            subtitle: Text("${_books[index].price.round()}€"),
            onTap: () => _router.push(BookRoute(book: _books[index])),
          ),
      separatorBuilder: (context, index) => const Divider());
}
