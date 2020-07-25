import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/ProductList.dart';

class ProductListNotifier with ChangeNotifier {

  List<ProductList> _productList=[];
  ProductList _currentProduct;

  UnmodifiableListView<ProductList> get productList=>UnmodifiableListView(_productList);
  ProductList get currentProduct=>_currentProduct;
  set productList(List<ProductList> productList){
    _productList=productList;
    notifyListeners();
  }
  set currentProduct(ProductList productList){
    _currentProduct=productList;
    notifyListeners();
  }


//  final firestoreService = ProductListApi();
//  String _id;
//  String _nama;
//  String _assets;
//
//  String get id => _id;
//  List get listOfProductList => listOfProduct;
//  String get nama =>_nama;
//  String get assets=> _assets;
//
//  //mencari ID
//  ProductList findById(String id) {
//    return _items.firstWhere((prod) => prod.id == id);
//  }
//
//  //menampilkan data
//  Future<void> fetchAndSetProducts() async {
//    const url = 'https://flutter-update.firebaseio.com/products.json';
//    try {
//      final response = await http.get(url);
//      final extractedData = json.decode(response.body) as Map<String, dynamic>;
//      if (extractedData == null) {
//        return;
//      }
//      final List<ProductList> loadedProducts = [];
//      extractedData.forEach((prodId, prodData) {
//        loadedProducts.add(ProductList(
//          id: prodId,
//          assets: prodData['assets'],
//          nama: prodData['nama'],
//          category_ref: prodData['category_ref'],
//        ));
//      });
//      _items = loadedProducts;
//      notifyListeners();
//    } catch (error) {
//      throw (error);
//    }
//  }
//
//  //add data
//  Future<void> addProduct(ProductList product) async {
//    const url = 'https://flutter-update.firebaseio.com/products.json';
//    try {
//      final response = await http.post(
//        url,
//        body: json.encode({
//          'nama': product.nama,
//          'category_ref': product.category_ref,
//          'assets': product.assets,
//        }),
//      );
//      final newProduct = ProductList(
//        nama: product.nama,
//        category_ref: product.category_ref,
//        assets: product.assets,
//        id: json.decode(response.body)['name'],
//      );
//      _items.add(newProduct);
//      // _items.insert(0, newProduct); // at the start of the list
//      notifyListeners();
//    } catch (error) {
//      print(error);
//      throw error;
//    }
//  }
//
//  //update data
//  Future<void> updateProduct(String id, ProductList newProduct) async {
//    final prodIndex = _items.indexWhere((prod) => prod.id == id);
//    if (prodIndex >= 0) {
//      final url = 'https://flutter-update.firebaseio.com/products/$id.json';
//      await http.patch(url,
//          body: json.encode({
//            'nama': newProduct.nama,
//            'assets': newProduct.assets,
//            'category_ref': newProduct.category_ref,
//          }));
//      _items[prodIndex] = newProduct;
//      notifyListeners();
//    } else {
//      print('...');
//    }
//  }
//
//  //delete data
//  Future<void> deleteProduct(String id) async {
//    final url = 'https://flutter-update.firebaseio.com/products/$id.json';
//    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
//    var existingProduct = _items[existingProductIndex];
//    _items.removeAt(existingProductIndex);
//    notifyListeners();
//    final response = await http.delete(url);
//    if (response.statusCode >= 400) {
//      _items.insert(existingProductIndex, existingProduct);
//      notifyListeners();
//      throw HttpException('Could not delete product.');
//    }
//    existingProduct = null;
//  }
}



