class ProductModel {
  int? id;
  String? image;
  String? name;
  int? quantity;
  double? price;
  double? rating;
  String? reviews;
  String? option;
  bool? isFavorite;
  bool? isBookmarked;
  ProductModel({
    this.id,
    this.image,
    this.name,
    this.quantity,
    this.price,
    this.rating,
    this.reviews,
    this.option,
    this.isFavorite,
    this.isBookmarked
  });
}