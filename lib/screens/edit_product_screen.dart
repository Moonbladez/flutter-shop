import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "./../providers/product.dart";
import "./../providers/products_provider.dart";

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  State<EditProductScreen> createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct =
      Product(description: "", id: null, imageUrl: "", price: 0, title: "");

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<ProductsProvider>(context, listen: false)
        .addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
          title: Text("Edit Product")),
      body: Padding(
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(label: Text("Title")),
                      onSaved: (value) {
                        _editedProduct = Product(
                            description: _editedProduct.description,
                            id: null,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                            title: value);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide a value";
                        }
                        return null;
                      }),
                  TextFormField(
                    decoration: InputDecoration(label: Text("Price")),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSaved: (value) {
                      _editedProduct = Product(
                          description: _editedProduct.description,
                          id: null,
                          imageUrl: _editedProduct.imageUrl,
                          price: double.parse(value),
                          title: _editedProduct.title);
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a price";
                      }

                      if (double.tryParse(value) == null) {
                        return "Please enter a valid number";
                      }

                      if (double.parse(value) <= 0) {
                        return "Please enter a number greater than 0";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(label: Text("Description")),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          description: value,
                          id: null,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                          title: _editedProduct.title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please emter a description";
                      }

                      if (value.length < 10) {
                        return "Description should be more than 10";
                      }

                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: _imageUrlController.text.isEmpty
                            ? Text("Enter a url")
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueGrey.shade100, width: 1)),
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 12),
                        width: 100,
                      ),
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(label: Text("Image URL")),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              description: _editedProduct.description,
                              id: null,
                              imageUrl: value,
                              price: _editedProduct.price,
                              title: _editedProduct.title);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter an image url";
                          }

                          if (!value.startsWith("http") &&
                              !value.startsWith("https")) {
                            return "Please enter a valid url";
                          }

                          if (!value.endsWith("jpg") &&
                              value.endsWith("png") &&
                              value.endsWith("jpeg")) {
                            return "Please enter a valid url";
                          }

                          return null;
                        },
                      ))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  )
                ],
              ),
            )),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
