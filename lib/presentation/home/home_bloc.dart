import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sample/domain/driving/request_books.dart';
import 'package:sample/domain/model/book.dart';

@injectable
class LibraryBloc extends Cubit<LibraryState> {
  final RequestBooks _requestBooks;

  LibraryBloc(this._requestBooks) : super(const LibraryState.unknown());

  void loadBooks() async {
    emit(const LibraryState.loadingBooks());
    final books = await _requestBooks.getBooks();
    emit(LibraryState.booksLoaded(books));
  }
}

enum LibraryStatus { unknown, loaded, loading }

class LibraryState {
  const LibraryState._({
    this.status = LibraryStatus.unknown,
    this.books = const [],
  });

  const LibraryState.unknown() : this._();

  const LibraryState.loadingBooks()
      : this._(
          status: LibraryStatus.loading,
        );

  const LibraryState.booksLoaded(List<Book> books)
      : this._(
          status: LibraryStatus.loaded,
          books: books,
        );

  final LibraryStatus status;
  final List<Book> books;
}
