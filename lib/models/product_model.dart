class ProductModel {
  String prodId;
  String prodNombre;
  String prodImagen;
  int prodPrecio;
  int prodCantidad;
  List<dynamic> prodUnidad;
  ProductModel(
      {required this.prodId,
      required this.prodNombre,
      required this.prodImagen,
      required this.prodPrecio,
      required this.prodCantidad,
      required this.prodUnidad,
      });
}
