import 'package:sample/domain/driven/obtain_offers.dart';
import 'package:sample/domain/driving/add_book.dart';
import 'package:sample/domain/driving/request_price.dart';
import 'package:sample/domain/model/book.dart';
import 'package:sample/domain/model/price.dart';

import 'model/offer.dart';

class CartUsecase implements AddBook, RequestPrice {
  final ObtainOffers _obtainOffers;

  CartUsecase(this._obtainOffers);

  @override
  List<Book> addBook(List<Book> books, Book book) => [...books, book];

  @override
  Future<Price> getPrice(List<Book> books) async {
    final offers =
        await _obtainOffers.getOffers(books.map((book) => book.isbn).toList());
    final originalPrice = books
        .map((book) => book.price)
        .reduce((value, element) => value + element);
    var cartPrice = Price(
      originalPrice: originalPrice,
      priceWithPromotion: originalPrice,
      promotionValue: 0,
    );
    for (var offer in offers) {
      double priceWithPromotion = 0;
      switch (offer.promotion) {
        case Promotion.minus:
          priceWithPromotion = cartPrice.originalPrice - offer.value;
          break;
        case Promotion.percentage:
          priceWithPromotion = cartPrice.originalPrice -
              cartPrice.originalPrice * offer.value / 100;
          break;
        case Promotion.slice:
          priceWithPromotion = cartPrice.originalPrice -
              ((cartPrice.originalPrice / offer.sliceValue!).round() *
                  offer.value);
          break;
      }
      if (priceWithPromotion < cartPrice.priceWithPromotion) {
        cartPrice = Price(
          originalPrice: originalPrice,
          priceWithPromotion: priceWithPromotion,
          promotionType: offer.promotion,
          promotionValue: offer.value,
          sliceValue: offer.sliceValue,
        );
      }
    }
    return cartPrice;
  }
}
