import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:valery/pages/detals/count.dart';
import 'package:valery/providers/cart_provider.dart';
import 'package:valery/utils/util.dart';

class SingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  bool wishList = false;
  int productPrice;
  String productId;
  int productQuantity;
  Function onDelete;
  var productUnit;
  SingleItem({
    required this.productQuantity,
    required this.productId,
    this.productUnit,
    required this.onDelete,
    required this.isBool,
    required this.productImage,
    required this.productName,
    required this.productPrice,
  });

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late CartProvider cartProvider;
  late int count;
  bool isTrue = false;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              //
              // imagen del producto...
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(widget.productImage,
                    height: 100, width: 120, fit: BoxFit.fill),
              ),
              //
              //
              //Expanded(
              //child:
              // --- CUERPO
              Container(
                height: 120,
                width: 180,
                //color: Colors.orange,
                child: Column(
                  mainAxisAlignment: widget.isBool == false
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.productName.length >= 35
                                ? widget.productName.substring(0, 35)
                                : widget.productName,
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '${widget.productUnit}\ \$ ${widget.productPrice}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    /*
                    widget.isBool == false
                        ? GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: new Text('50 Gram'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: new Text('500 Gram'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: new Text('1 Kg'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  /*Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    )*/
                                ],
                              ),
                            ),
                          )
                        : Text(widget.productUnit)
                        */
                  ],
                ),
              ),
              //),
              //
              //
              //Expanded(
              //child:
              Container(
                height: 120,
                width: 70,
                //color: Colors.orange,
                padding: widget.isBool == false
                    ? EdgeInsets.symmetric(horizontal: 15, vertical: 50)
                    : EdgeInsets.only(right: 1),
                child: widget.isBool == false
                    ? Count(
                        productId: widget.productId,
                        productImage: widget.productImage,
                        productName: widget.productName,
                        productPrice: widget.productPrice,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                //
                                setState(() {
                                  //widget.isBool = false;
                                  isTrue = false;
                                });
                                cartProvider
                                    .reviewCartDataDelete(widget.productId);
                                //
                              }, //widget.onDelete,
                              child: Icon(
                                Icons.delete,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.wishList == false
                                ? Container(
                                    height: 25,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (count == 1) {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Llegas al límite mínimo.",
                                                );
                                              } else {
                                                setState(() {
                                                  count--;
                                                });
                                                cartProvider.updateCartData(
                                                  cartImage:
                                                      widget.productImage,
                                                  cartId: widget.productId,
                                                  cartName: widget.productName,
                                                  cartPrice:
                                                      widget.productPrice,
                                                  cartQuantity: count,
                                                );
                                              }
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            "$count",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (count < 10) {
                                                setState(() {
                                                  count++;
                                                });
                                                cartProvider.updateCartData(
                                                  cartImage:
                                                      widget.productImage,
                                                  cartId: widget.productId,
                                                  cartName: widget.productName,
                                                  cartPrice:
                                                      widget.productPrice,
                                                  cartQuantity: count,
                                                );
                                              }
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
              ),
              //),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              )
      ],
    );
  }
}
