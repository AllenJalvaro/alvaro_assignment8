import 'package:alvaro_assignment8/helper/db_helper.dart';
import 'package:alvaro_assignment8/models/product_item.dart';
import 'package:alvaro_assignment8/screens/product_add.dart';
import 'package:alvaro_assignment8/screens/product_edit.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final DBHelper productDatabase = DBHelper.instance;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  _loadProducts() async {
    List<Product> productList = await productDatabase.getProducts();
    setState(() {
      products = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              ).then((_) {
                _loadProducts();
              });
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text('No products available.'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                  ),
                  title: Text(product.name),
                  subtitle: Text('Php ${product.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.amber,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProduct(product: product),
                            ),
                          ).then((_) {
                            _loadProducts();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          _showDeleteConfirmationDialog(product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to delete ${product.name} Are you sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await productDatabase.deleteProduct(product.sku);
                Navigator.of(context).pop();
                _loadProducts();
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
          ],
        );
      },
    );
  }
}
