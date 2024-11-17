// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsys/controller/api_service/api_service.dart';
import 'package:microsys/main.dart';
import 'package:microsys/model/item_model/item_model.dart';
import '../../view/utils/colors.dart';

class ItemController extends ChangeNotifier {
  GlobalKey<FormState> itemFormKey = GlobalKey<FormState>();

  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isLoading = false;
  String selectedCategory = '';
  List<ItemModel> itemList = [];

  selectCategory(value) {
    selectedCategory = value;
    notifyListeners();
  }

  Future<void> addItemsToFirebase() async {
    try {
      ApiService.addToFirebase(
        collectionName: 'items',
        body: {
          'itemName': itemNameController.text.trim(),
          'description': descriptionController.text.trim(),
          'unit': unitController.text.trim(),
          'price': priceController.text.trim(),
          'category': selectedCategory,
        },
      );

      // Fetch updated categories
      await fetchItems();

      // Navigate back and show success message
      Navigator.of(NavigationService.navigatorKey.currentState!.context)
        ..pop()
        ..pop();
      Fluttertoast.showToast(
        msg: 'Item added successfully',
        backgroundColor: green,
      );

      // Clear the form fields
      itemNameController.clear();
      descriptionController.clear();
      unitController.clear();
      priceController.clear();

      log('item added successfully!');
    } catch (e) {
      log('Error adding item: $e');
      Fluttertoast.showToast(
        msg: 'Failed to add item: $e',
        backgroundColor: red,
      );
    }
  }

  Future<List<ItemModel>> fetchItems() async {
    isLoading = true;
    try {
      final QuerySnapshot querySnapshot =
          await ApiService.fetchDataFromFirebase(collectionName: 'items');

      // Convert the fetched documents into a list of ItemModel
      List<ItemModel> items = querySnapshot.docs.map((doc) {
        return ItemModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      itemList = items;
      isLoading = false;
      notifyListeners();
      return items;
    } catch (e) {
      isLoading = false;
      log('Error fetching items: $e');
      return [];
    }
  }

  Future<void> editItems({required String categoryId}) async {
    try {
      ApiService.editCollectionDataInFirebase(
        categoryId: categoryId,
        collectionName: 'items',
        body: {
          'itemName': itemNameController.text.trim(),
          'description': descriptionController.text.trim(),
          'unit': unitController.text.trim(),
          'price': priceController.text.trim(),
          'category': selectedCategory,
        },
      );

      // Fetch updated categories
      await fetchItems();

      // Navigate back and show success message
      Navigator.of(NavigationService.navigatorKey.currentState!.context)
        ..pop()
        ..pop()
        ..pop();
      Fluttertoast.showToast(
        msg: 'Items updated successfully',
        backgroundColor: green,
      );

      log('items updated successfully');
    } catch (e) {
      log('Error updating items: $e');
      throw Exception('Failed to update items');
    }
  }

  Future<void> deleteItemFromFirebase(String id) async {
    try {
      ApiService.deleteFromFirebase(
        collectionName: 'items',
        id: id,
      );
      // Fetch updated categories
      await fetchItems();

      // Navigate back and show success message
      Navigator.of(NavigationService.navigatorKey.currentState!.context)
        ..pop()
        ..pop();

      Fluttertoast.showToast(
        msg: 'Item deleted',
        backgroundColor: green,
      );
      log('item deleted successfully!');
    } catch (e) {
      log('Error deleting item: $e');
      Fluttertoast.showToast(
        msg: 'Failed to delete item: $e',
        backgroundColor: red,
      );
    }
  }
}
