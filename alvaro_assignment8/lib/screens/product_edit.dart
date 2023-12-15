import 'package:alvaro_assignment8/helper/db_helper.dart';
import 'package:alvaro_assignment8/models/product_item.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct({required this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountedPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    priceController.text = widget.product.price.toString();
    discountedPriceController.text = widget.product.discountedPrice.toString();
    quantityController.text = widget.product.quantity.toString();
    manufacturerController.text = widget.product.manufacturer.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountedPriceController.dispose();
    quantityController.dispose();
    manufacturerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: discountedPriceController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Discounted Price'),
            ),
            TextField(
              controller: quantityController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: manufacturerController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(labelText: 'Manufacturer'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Product updatedProduct = Product(
                  sku: widget.product.sku,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                  discountedPrice: double.parse(discountedPriceController.text),
                  quantity: int.parse(quantityController.text),
                  manufacturer: manufacturerController.text,
                );
                await DBHelper.instance.updateProduct(updatedProduct);
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
