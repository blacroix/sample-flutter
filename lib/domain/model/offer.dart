class Offer {
  final Promotion promotion;
  final double value;
  final double? sliceValue;

  Offer(this.promotion, this.value, this.sliceValue);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Offer &&
          runtimeType == other.runtimeType &&
          promotion == other.promotion &&
          value == other.value &&
          sliceValue == other.sliceValue;

  @override
  int get hashCode => promotion.hashCode ^ value.hashCode ^ sliceValue.hashCode;
}

enum Promotion {
  minus,
  percentage,
  slice;
}
