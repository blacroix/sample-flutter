import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/domain/cart_usecase.dart';
import 'package:sample/domain/driven/obtain_offers.dart';
import 'package:sample/domain/model/book.dart';
import 'package:sample/domain/model/offer.dart';
import 'package:sample/domain/model/price.dart';

import 'cart_usecase_test.mocks.dart';

@GenerateMocks([ObtainOffers])
void main() {
  final obtainOffers = MockObtainOffers();
  final cartUsecase = CartUsecase(obtainOffers);
  final books = [
    Book('title', 'cover', 'synopsis', 'isbn', 1),
  ];
  final isbns = ['isbn'];

  group('Get price', () {
    test('should not apply promotion', () async {
      when(obtainOffers.getOffers(isbns)).thenAnswer((_) async => []);

      final price = await cartUsecase.getPrice(books);

      expect(
          price,
          equals(Price(
            originalPrice: 1,
            priceWithPromotion: 1,
            promotionValue: 0,
          )));
    });

    test('should apply minus among others', () async {
      when(obtainOffers.getOffers(isbns)).thenAnswer((_) async => [
        Offer(Promotion.minus, 0.2, null),
        Offer(Promotion.percentage, 10, null),
        Offer(Promotion.slice, 0.1, 1),
      ]);

      final price = await cartUsecase.getPrice(books);

      expect(
          price,
          equals(Price(
            originalPrice: 1,
            priceWithPromotion: 0.8,
            promotionValue: 0.2,
            promotionType: Promotion.minus,
          )));
    });

    test('should apply percentage among others', () async {
      when(obtainOffers.getOffers(isbns)).thenAnswer((_) async => [
        Offer(Promotion.minus, 0.1, null),
        Offer(Promotion.percentage, 20, null),
        Offer(Promotion.slice, 0.1, 1),
      ]);

      final price = await cartUsecase.getPrice(books);

      expect(
          price,
          equals(Price(
            originalPrice: 1,
            priceWithPromotion: 0.8,
            promotionValue: 20,
            promotionType: Promotion.percentage,
          )));
    });

    test('should apply slice among others', () async {
      when(obtainOffers.getOffers(isbns)).thenAnswer((_) async => [
        Offer(Promotion.minus, 0.1, null),
        Offer(Promotion.percentage, 10, null),
        Offer(Promotion.slice, 0.2, 1),
      ]);

      final price = await cartUsecase.getPrice(books);

      expect(
          price,
          equals(Price(
            originalPrice: 1,
            priceWithPromotion: 0.8,
            promotionValue: 0.2,
            sliceValue: 1,
            promotionType: Promotion.slice,
          )));
    });
  });
}
