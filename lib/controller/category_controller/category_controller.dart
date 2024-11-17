// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:microsys/controller/api_service/api_service.dart';
import 'package:microsys/main.dart';

import '../../model/category_model/category_model.dart';
import '../../view/utils/colors.dart';

class CategoryController extends ChangeNotifier {
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isActive = false;
  bool isLoading = false;

  List<CategoryModel> categoryList = [];

  isActiveToggle() {
    isActive = !isActive;
    notifyListeners();
  }

  Future<void> addCategoryToFirebase() async {
    try {
      ApiService.addToFirebase(
        collectionName: 'categories',
        body: {
          'categoryName': categoryNameController.text.trim(),
          'description': descriptionController.text.trim(),
          'isActive': isActive,
        },
      );

      // Fetch updated categories
      await fetchCategories();

      // Navigate back and show success message
      Navigator.of(NavigationService.navigatorKey.currentState!.context)
        ..pop()
        ..pop();
      Fluttertoast.showToast(
        msg: 'Category added successfully',
        backgroundColor: green,
      );

      // Clear the form fields and reset isActive
      categoryNameController.clear();
      descriptionController.clear();
      isActive = false;
      log('Category added successfully!');
    } catch (e) {
      log('Error adding category: $e');
      Fluttertoast.showToast(
        msg: 'Failed to add category: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    isLoading = true;
    try {
      final QuerySnapshot querySnapshot =
          await ApiService.fetchDataFromFirebase(
        collectionName: 'categories',
      );

      // Convert the fetched documents into a list of CategoryModel
      List<CategoryModel> categories = querySnapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      categoryList = categories;
      isLoading = false;
      notifyListeners();
      return categories;
    } catch (e) {
      log('Error fetching categories: $e');
      isLoading = false;
      return [];
    }
  }

  Future<void> editCategory({required String categoryId}) async {
    try {
      ApiService.editCollectionDataInFirebase(
        categoryId: categoryId,
        collectionName: 'categories',
        body: {
          'categoryName': categoryNameController.text.trim(),
          'description': descriptionController.text.trim(),
          'isActive': isActive,
        },
      );

      // Fetch updated categories
      await fetchCategories();

      // Navigate back and show success message
      Navigator.of(NavigationService.navigatorKey.currentState!.context)
        ..pop()
        ..pop()
        ..pop();
      Fluttertoast.showToast(
        msg: 'Category updated successfully',
        backgroundColor: green,
      );

      log('Category updated successfully');
    } catch (e) {
      log('Error updating category: $e');
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategoryFromFirebase(String id) async {
    try {
      ApiService.deleteFromFirebase(
        collectionName: 'categories',
        id: id,
      );

      // Fetch updated categories
      await fetchCategories();

      // Navigate back and show success message
      Navigator.of(NavigationService.navigatorKey.currentState!.context)
        ..pop()
        ..pop();

      Fluttertoast.showToast(
        msg: 'Category deleted',
        backgroundColor: green,
      );
      log('Category deleted successfully!');
    } catch (e) {
      log('Error deleting category: $e');
      Fluttertoast.showToast(
        msg: 'Failed to delete category: $e',
        backgroundColor: red,
      );
    }
  }
}
