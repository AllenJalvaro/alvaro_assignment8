import 'package:alvaro_assignment8/helper/db_helper.dart';
import 'package:alvaro_assignment8/models/product_item.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  final DBHelper dbProduct = DBHelper.instance;
  final TextEditingController skuController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: skuController,
                decoration: InputDecoration(labelText: 'SKU'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Discounted Price'),
              ),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
              TextField(
                controller: manufacturerController,
                decoration: InputDecoration(labelText: 'Manufacturer'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Product newProduct = Product(
                    sku: skuController.text,
                    name: nameController.text,
                    description: descController.text,
                    price: double.parse(priceController.text),
                    discountedPrice: double.parse(discountController.text),
                    quantity: int.parse(quantityController.text),
                    manufacturer: manufacturerController.text,
                  );
                  await dbProduct.addProduct(newProduct);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
