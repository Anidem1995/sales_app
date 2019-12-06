class Product {
  int product_id;
  String name;
  double price;
  int stock;
  int reorder;
  int commited;
  bool active;
  String image;

  Product({this.product_id, this.name, this.price, this.stock, this.reorder, this.commited, this.active, this.image});

  factory Product.fromJson(Map jsonMap) {
    return Product (
      product_id: jsonMap['id'],
      name: jsonMap['name'],
      price: jsonMap['price'],
      stock: jsonMap['stock'],
      reorder: jsonMap['reorder'],
      commited: jsonMap['commited'],
      active: jsonMap['active'],
      image: jsonMap['image']
    );
  }
}

class ProductsList {
  List<Product> products;
  
  ProductsList({this.products});
  
  factory ProductsList.fromJson(List<dynamic> jsonList) {
    List<Product> products = List<Product>();
    products = jsonList.map((i) => Product.fromJson(i)).toList();
    return ProductsList(products: products);
  }
}
