import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/injection.dart';
import 'package:sample/presentation/home/home_bloc.dart';
import 'package:sample/presentation/home/widgets/widget_book_list.dart';
import 'package:sample/presentation/home/widgets/widget_loading.dart';
import 'package:sample/presentation/home/widgets/widget_welcome.dart';

import '../../app_router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LibraryBloc _libraryBloc = getIt<LibraryBloc>();
  final AppRouter _router = getIt<AppRouter>();

  @override
  void initState() {
    _libraryBloc.loadBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Library"),
          actions: [
            IconButton(
                onPressed: () => _router.push(const CartRoute()),
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: BlocBuilder<LibraryBloc, LibraryState>(
            bloc: _libraryBloc,
            builder: (context, state) {
              switch (state.status) {
                case LibraryStatus.unknown:
                  return const WidgetWelcome();
                case LibraryStatus.loaded:
                  return WidgetBookList(state.books);
                case LibraryStatus.loading:
                  return const WidgetLoading();
              }
            }),
      );
}
