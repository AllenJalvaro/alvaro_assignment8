class Product {
  final String sku;
  final String name;
  final String description;
  final double price;
  final double discountedPrice;
  final int quantity;
  final String? manufacturer;

  Product({
    required this.sku,
    required this.name,
    required this.description,
    required this.price,
    required this.discountedPrice,
    required this.quantity,
    this.manufacturer,
  });

  Map<String, dynamic> toMap() {
    return {
      'productSKU': sku,
      'productName': name,
      'productDescription': description,
      'productPrice': price,
      'productDiscountedPrice': discountedPrice,
      'productQuantity': quantity,
      'productManufacturer': manufacturer,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      sku: map['productSKU'],
      name: map['productName'],
      description: map['productDescription'],
      price: map['productPrice'],
      discountedPrice: map['productDiscountedPrice'],
      quantity: map['productQuantity'],
      manufacturer: map['productManufacturer'],
    );
  }
}
