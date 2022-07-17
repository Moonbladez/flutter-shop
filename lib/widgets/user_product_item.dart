import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./../screens/edit_product_screen.dart";
import "./../providers/products_provider.dart";

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.id, this.title, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        trailing: Container(
          child: Row(children: [
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Delete failed"),
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                  ));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ]),
          width: 100,
        ),
        title: Text(title));
  }
}
