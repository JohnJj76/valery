import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valery/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      prodId: element.get("prodId"),
      prodNombre: element.get("prodNombre"),
      prodImagen: element.get("prodImagen"),
      prodPrecio: element.get("prodPrecio"),
      prodUnidad: element.get("prodUnidad"),
      prodCantidad: 1,
    );
    search.add(productModel);
  }

  /////////////// HANBURGUESAS ///////////////////////////////
  ///
  List<ProductModel> hamburguesasProductList = [];
  hamburguesasProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("hamburguesas").get();
    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    hamburguesasProductList = newList;
    notifyListeners();
  }
  List<ProductModel> get getHamburguesasProductDataList {
    return hamburguesasProductList;
  }



  //////////////// MALTEADAS ///////////////////////////////////////
  ///
  List<ProductModel> malteadasProductList = [];
  malteadasProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("malteadas").get();
    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    malteadasProductList = newList;
    notifyListeners();
  }
  List<ProductModel> get getMalteadasProductDataList {
    return malteadasProductList;
  }


  //////////////// SALCHIPAPAS ///////////////////////////////////////
  List<ProductModel> salchipapasProductList = [];
  salchipapasProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("salchipapas").get();
    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    salchipapasProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getSalchipapasProductDataList {
    return salchipapasProductList;
  }




  /////////////////// Search Return ////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}
