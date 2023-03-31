class Product {
  final String? name;
  final String? image;
  late final int? quantity;
  final int? price;
  late final bool? outOfStock;
  late final bool? counterStart;

  Product({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.outOfStock,
    required this.counterStart,
  });

  factory Product.fromMap({required Product data}) {
    return Product(
      name: data.name,
      image: data.image,
      quantity: data.quantity,
      price: data.price,
      outOfStock: data.outOfStock,
      counterStart: data.counterStart,
    );
  }
}

class ProductDB {
  final int? id;
  final String? name;
  final String? image;
  final int? quantity;
  final int? price;
  final bool? outOfStock;
  final bool? counterStart;

  ProductDB({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.outOfStock,
    required this.counterStart,
  });

  factory ProductDB.fromMap({required Map data}) {
    return ProductDB(
      id: data["Id"],
      name: data['Name'],
      image: data['Image'],
      quantity: data['Quantity'],
      price: data['Price'],
      outOfStock: data['OutOfStock'],
      counterStart: data['CounterStart'],
    );
  }
}
