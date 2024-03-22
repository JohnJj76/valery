import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valery/providers/cart_provider.dart';
import 'package:valery/utils/util.dart';

class Count extends StatefulWidget {
  String productName;
  String productImage;
  String productId;
  int productPrice;
  var productUnit;

  Count({
    required this.productName,
    this.productUnit,
    required this.productId,
    required this.productImage,
    required this.productPrice,
  });
  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    CartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 40,
      width: 110,
      decoration: BoxDecoration(
        color: botonAgre,
        border: Border.all(color: botonAgre),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                    } else if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "$count",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          : Center(
              child: FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addCartData(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    cartUnit: widget.productUnit,
                  );
                },
                label: const Text('AGREGAR',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                backgroundColor: fondoLogin,
              ),
            ),
    );
  }
}
