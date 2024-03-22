import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:valery/models/product_model.dart';
import 'package:valery/pages/detals/count.dart';
import 'package:valery/pages/detals/product_unit.dart';
import 'package:valery/utils/util.dart';

class SingalProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final Function onTap;
  final String productId;
  final ProductModel productUnit;
  SingalProduct(
      {required this.productId,
      required this.productImage,
      required this.productName,
      required this.productUnit,
      required this.onTap,
      required this.productPrice});

  @override
  _SingalProductState createState() => _SingalProductState();
}

class _SingalProductState extends State<SingalProduct> {
  var unitData;
  var firstValue;
  late bool bandera;

  @override
  Widget build(BuildContext context) {
    widget.productUnit.prodUnidad.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 220,
            height: 300,
            decoration: BoxDecoration(
              color: fondoCard,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*
                GestureDetector(
                  onTap: () {},
                  //
                  //
                  child: Container(
                      height: 160,
                      width: 220,
                      decoration: BoxDecoration(
                        color: fondoCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: 
                      /*child: Image.network(
                      height: 50,
                      width: 50,
                      widget.productImage,
                    ),*/
                      ),

                  /*
                  child: Container(
                    height: 150,
                    width: 210,
                    decoration: BoxDecoration(
                      color: fondoCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Image.network(
                      widget.productImage,
                    ),

                    /*
                    decoration: BoxDecoration(
                      color: botonLogin,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Image.network(
                      widget.productImage,
                    ),
                    */
                  ),
                  */
                ),*/
                //
                //
                // --- IMAGEN
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(widget.productImage,
                      height: 180, width: 220, fit: BoxFit.fill),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName.length >= 17
                              ? widget.productName.substring(0, 17)
                              : widget.productName,
                          style: TextStyle(
                            fontSize: 17,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${"Precio "}\$ ${widget.productPrice}',
                          //'${widget.productPrice}\$/${unitData == null ? firstValue : unitData}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ProductUnit(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: widget
                                              .productUnit.prodUnidad
                                              .map<Widget>((data) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        unitData = data;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      data,
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        );
                                      });
                                },
                                title: unitData == null ? firstValue : unitData,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Count(
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice,
                              productUnit:
                                  unitData == null ? firstValue : unitData,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
