class CartModel {
  String cartId;
  String cartName;
  String cartImage;
  int cartPrice;
  int cartQuantity;
  var cartUnit;
  CartModel({
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartQuantity,
    this.cartUnit,
  });
}
