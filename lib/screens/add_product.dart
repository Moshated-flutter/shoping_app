// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/product.dart';
import 'package:shoping_app/providers/product_providers.dart';
import 'package:shoping_app/screens/user_product.dart';
import 'package:shoping_app/widgets/product_list_user.dart';

class AddProduct extends StatefulWidget {
  static const routename = '/addproduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _priceFocusnode = FocusNode();
  final _desFocusnode = FocusNode();
  final _imageURLfocusNode = FocusNode();
  final _imageurlcontroler = TextEditingController();
  final formkey = GlobalKey<FormState>();

  var _isloading = false;

  var _editedProduct = Product_models(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  @override
  void initState() {
    _imageURLfocusNode.addListener(updateimageUrl);
    super.initState();
  }

  void updateimageUrl() {
    if (!_imageURLfocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform(BuildContext context1) {
    return showDialog(
      context: context1,
      builder: (cont) {
        return AlertDialog(
          title: const Text('Do you want to add the item ?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                formkey.currentState!.save();
                setState(() {
                  _isloading = true;
                });
                Navigator.of(cont).pop();

                Provider.of<Products_provider>(cont, listen: false)
                    .addproduct(_editedProduct)
                    .catchError((error) {
                  return showDialog<void>(
                    context: context,
                    builder: (contextshowdialog) {
                      return AlertDialog(
                        title: const Text('An error occurred!'),
                        content: const Text('Something went wrong'),
                        actions: [
                          ElevatedButton(
                            onPressed: () =>
                                Navigator.of(contextshowdialog).pop(),
                            child: const Text('okey!'),
                          ),
                        ],
                      );
                    },
                  );
                }).then((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      UserProductScreen.routename, (route) => false);
                });
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(cont).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _imageURLfocusNode.removeListener(updateimageUrl);
    _priceFocusnode.dispose();
    _imageurlcontroler.dispose();
    _desFocusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (!formkey.currentState!.validate()) {
                return null;
              }
              _saveform(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
        title: const Text('Add your produc'),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: formkey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_priceFocusnode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a value';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product_models(
                              id: _editedProduct.id,
                              title: newValue.toString(),
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_desFocusnode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a value';
                          }
                          if (double.tryParse(value.toString()) == null) {
                            return 'Enter a valid value.';
                          }
                          if (double.parse(value.toString()) <= 0) {
                            return 'Enter a value greater than zero!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue!.isEmpty) {
                            return null;
                          } else {
                            if (double.tryParse(newValue.toString()) == null) {
                              return null;
                            } else {
                              _editedProduct = Product_models(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: double.parse(newValue.toString()),
                                  imageUrl: _editedProduct.imageUrl);
                            }
                          }
                        },
                        focusNode: _priceFocusnode,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'describtions'),
                        keyboardType: TextInputType.multiline,
                        focusNode: _desFocusnode,
                        maxLines: 3,
                        onSaved: (newValue) {
                          _editedProduct = Product_models(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: newValue.toString(),
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a value';
                          }
                          if (value.toString().length < 10) {
                            return 'add more descriptions';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            // ignore: sort_child_properties_last
                            child: _imageurlcontroler.text.isEmpty
                                ? const Text('Enter the Url')
                                : FittedBox(
                                    child: Image.network(
                                      _imageurlcontroler.text,
                                    ),
                                  ),
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Image Url'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageurlcontroler,
                              focusNode: _imageURLfocusNode,
                              onSaved: (newValue) {
                                _editedProduct = Product_models(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: newValue.toString(),
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter a value';
                                }
                                if (!value.startsWith('http') ||
                                    !value.startsWith('https')) {
                                  return 'Enter a valid image Url.';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                if (!formkey.currentState!.validate()) {
                                  return null;
                                }
                                _saveform(context);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
