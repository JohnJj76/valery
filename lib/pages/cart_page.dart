import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:valery/models/cart_model.dart';
import 'package:valery/pages/detals/single_item.dart';
import 'package:valery/pages/home_screen.dart';
import 'package:valery/providers/cart_provider.dart';
import 'package:valery/utils/util.dart';


class CartPage extends StatelessWidget {
  late CartProvider reviewCartProvider;
  showAlertDialog(BuildContext context, CartModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    String countryCodeText = '57';
    String numberText = '3013712298';
    String message = "este es mi pedido";
    String phone = '573013712298';
    //

    reviewCartProvider = Provider.of<CartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      backgroundColor: fondoHome,
      bottomNavigationBar: ListTile(
        title: Text("Gran Total"),
        subtitle: Text(
          "\$ ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text("Pagar"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () async {
              /*
              // enviar a wasap abriendolo
              var whatsappUrl = Uri.parse(
                    "whatsapp://send?phone=${countryCodeText + numberText}" +
                        "&text=${Uri.encodeComponent("Your Message Here")}");
                try {
                  launchUrl(whatsappUrl);
                } catch (e) {
                  debugPrint(e.toString());
                }
                */

              //0tra
              final url = 'https://wa.me/57$numberText?text=$message';
              await launchUrlString(
                url,
                mode: LaunchMode.externalApplication,
              );

              /*
              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                //return Container(child: Text("No Cart Data Found"));
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryDetails(),
                ),
              );
              */
            },
          ),
        ),
      ),
      appBar: AppBar(
        //actions: [Widget],
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "CARRITO DE COMPRAS",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Text("NO HAY DATA"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                CartModel data =
                    reviewCartProvider.getReviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    SingleItem(
                      isBool: true,
                      productImage: data.cartImage,
                      productName: data.cartName,
                      productPrice: data.cartPrice,
                      productId: data.cartId,
                      productQuantity: data.cartQuantity,
                      productUnit: data.cartUnit,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
