import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_kart/model/Product.dart';
import 'package:flutter_kart/model/hotel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsModel extends Model {
  List<Hotel> _hotelList = [];
  List<Product> _products = [];
  List<Product> _cartList = [];
  final baseUrl = 'http://api.flutterapp.in/api/';

  ProductsModel() {
    _products.add(Product(
      'Aminoacidos BCAA',
      'Complejo de Hidratación Hydragen (Calcio + Agua de Coco) Forzagen Premium Series, 330 g',
      300,
      'https://images-na.ssl-images-amazon.com/images/I/614qtGS2hEL._AC_SL1500_.jpg',
    ));

    _products.add(Product(
      'Muscletech',
      'Mezcla de Proteínas y Aminoácidos Nitro-Tech Ripped, Chocolate Fudge Brownie, 4 lb',
      200,
      'https://images-na.ssl-images-amazon.com/images/I/81n%2BSvwc4yL._AC_SL1500_.jpg',
    ));

    _products.add(Product(
      'MuscleMeds',
      'Carnivor Chocolate, 4.6 lb',
      500,
      'https://images-na.ssl-images-amazon.com/images/I/71A2p4quCkL._AC_SL1500_.jpg',
    ));

    _products.add(Product(
      'MAD LABZ BCAA',
      'Glutamina, Sabor Fresandía, 210 g',
      120,
      'https://images-na.ssl-images-amazon.com/images/I/711HaYtrRnL._AC_SL1224_.jpg',
    ));

    _products.add(Product(
      'MDN Wheyner MASS',
      '(Triple chocolate) 10lbs',
      450,
      'https://images-na.ssl-images-amazon.com/images/I/71Oqm-aQFYL._AC_SL1080_.jpg',
    ));


    _hotelList.add(Hotel(
        'Amazon',
        'https://logosmarcas.com/wp-content/uploads/2018/05/Amazon-S%C3%ADmbolo.png',
        'Amazon Mexico',
        '2-5 dias',
        4.8,
        500));

    _hotelList.add(Hotel(
        'Mercado Libre',
        'https://seeklogo.com/images/M/Mercado_Libre-logo-990B0B4963-seeklogo.com.png',
        'Colombia',
        '3-5 dias',
        4.3,
        500));
  }

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get getCartList {
    return List.from(_cartList);
  }

  List<Hotel> get getHotelList {
    return List.from(_hotelList);
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Product pro) {
      price += pro.price;
    });
    return price;
  }

  void addProduct(Product product) {
    final Map<String, dynamic> productMap = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://www.dinneratthezoo.com/wp-content/uploads/2016/10/veggie-fried-rice-6-500x500.jpg',
    };

    http.post(
      baseUrl + 'products',
      body: json.encode(productMap),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      },
    );
    _products.add(product);
    notifyListeners();
  }

 getProductList() async {
  final data = await  http
        .get(
      baseUrl + 'products',
    )
        .then(
      (response) {
       
      },
    );
    
  }

  void addToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }
}
