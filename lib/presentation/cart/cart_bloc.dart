import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sample/domain/model/price.dart';

import '../../domain/driving/add_book.dart';
import '../../domain/driving/request_price.dart';
import '../../domain/model/book.dart';
import '../../domain/model/offer.dart';

@injectable
class CartBloc extends Cubit<CartState> {
  final AddBook _addBook;
  final RequestPrice _requestPrice;

  CartBloc(this._addBook, this._requestPrice) : super(const CartState.empty());

  void addBook(Book book) {
    final books = _addBook.addBook(state.books, book);
    emit(CartState.bookAdded(books));
  }

  void requestPrice() async {
    final price = await _requestPrice.getPrice(state.books);
    emit(CartState.priceCalculated(state.books, price));
  }
}

enum CartStatus { empty, bookAdded, priceCalculated }

class CartState {
  final List<Book> books;
  final CartStatus status;
  final Price? price;

  const CartState._({
    this.books = const [],
    this.status = CartStatus.empty,
    this.price,
  });

  const CartState.empty() : this._();

  const CartState.bookAdded(List<Book> books)
      : this._(books: books, status: CartStatus.bookAdded);

  const CartState.priceCalculated(List<Book> books, Price price)
      : this._(books: books, price: price, status: CartStatus.priceCalculated);

  String getDiscountMessage() {
    var message = '';
    switch (price?.promotionType) {
      case Promotion.minus:
        message = "minus ${price?.promotionValue}€";
        break;
      case Promotion.percentage:
        message = "-${price?.promotionValue}%";
        break;
      case Promotion.slice:
        message = "-${price?.promotionValue}€ every ${price?.sliceValue}€";
        break;
      case null:
        message = "none ;(";
        break;
    }
    return message;
  }

  String getPriceMessage() => price?.priceWithPromotion != null ? "${price?.priceWithPromotion.toString()}€" : '-';
}
