import 'package:flutter/material.dart';

class Productitem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  Productitem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          leading: IconButton(
              icon: Icon(
            Icons.favorite,
            color: Theme.of(context).colorScheme.secondary,
          )),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
            Icons.shopping_cart,
            color: Theme.of(context).colorScheme.secondary,
          )),
        ),
      ),
    );
  }
}
