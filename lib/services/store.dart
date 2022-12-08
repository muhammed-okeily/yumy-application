// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/constants/constants.dart';

import '../models/productModel.dart';

class Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddProduct(Product product) {
    firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return firestore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(documentId) {
    firestore.collection(kProductsCollection).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    firestore.collection(kProductsCollection).doc(documentId).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductLocation: product.pLocation,
        kProductCategory: product.pCategory,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  deleteOrder(documentId) {
    firestore.collection(kOrders).doc(documentId).delete();
  }

  


}
