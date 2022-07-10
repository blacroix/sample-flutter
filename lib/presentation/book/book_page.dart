import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/injection.dart';
import 'package:sample/presentation/cart/cart_bloc.dart';

import '../../app_router.gr.dart';
import '../../domain/model/book.dart';

class BookPage extends StatelessWidget {
  final Book book;
  final _router = getIt<AppRouter>();

  BookPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Book'),
          actions: [
            IconButton(
                onPressed: () => _router.push(const CartRoute()),
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            switch (state.status) {
              case CartStatus.priceCalculated:
              case CartStatus.empty:
                break;
              case CartStatus.bookAdded:
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Book added')));
                break;
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: SizedBox(
                  width: 200,
                  height: 300,
                  child: Image.network(book.cover),
                )),
              ),
              Text(
                book.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "${book.price.round()}€",
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Text(
                  book.synopsis,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_shopping_cart),
          onPressed: () => context.read<CartBloc>().addBook(book),
        ),
      );
}
