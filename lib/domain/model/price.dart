import 'offer.dart';

class Price {
  final double originalPrice;
  final double priceWithPromotion;
  final double promotionValue;
  final double? sliceValue;
  final Promotion? promotionType;

  Price({
    required this.originalPrice,
    required this.priceWithPromotion,
    required this.promotionValue,
    this.promotionType,
    this.sliceValue,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Price &&
          runtimeType == other.runtimeType &&
          originalPrice == other.originalPrice &&
          priceWithPromotion == other.priceWithPromotion &&
          promotionValue == other.promotionValue &&
          sliceValue == other.sliceValue &&
          promotionType == other.promotionType;

  @override
  int get hashCode =>
      originalPrice.hashCode ^
      priceWithPromotion.hashCode ^
      promotionValue.hashCode ^
      sliceValue.hashCode ^
      promotionType.hashCode;
}
